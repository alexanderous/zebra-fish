class CommentsController < ApplicationController
	before_filter :signed_in_user
    before_filter :correct_user, only: [:destroy]
    #before_filter :kin_user, only: :show

	def create
        session[:return_to] ||= request.referer
        @anthology_item = Micropost.find(params[:micropost_id])
    	@micropost = Micropost.find(params[:micropost_id])
		@comment = @micropost.comments.build(params[:comment])
		@comment.user = current_user

		if @comment.save
      		flash[:success] = "Comment published!"
            if current_user != @micropost.user
                CommentAuthorNotificationsWorker.perform_async(@comment.id)
            end
            if current_user != @micropost.subject && !@micropost.subject.dead?
                CommentSubjectNotificationsWorker.perform_async(@comment.id)
            end
            render 'comments/index'
   		else
            render 'comments/index'
        end
    end

    def show
    end

    def index
        @user = current_user
        @micropost = Micropost.find(params[:micropost_id])
        @fans = @micropost.lovers.all
        @users = User.search(params[:search], params[:page]) 
    end

    def destroy
    	@comment = current_user.comments.find(params[:id])
    	@micropost = Micropost.find(params[:id]) # before, it was :article_id -- not sure why
    	@comment.destroy
        redirect_to @micropost
    end
    	

    private

        def correct_user
             Comment.find(params[:id]).user_id && Micropost.find(params[:id]).subject_id && Micropost.find(params[:id]).user_id && User.where(:admin => "true")
          #if this doesn't work, try user and subject (without the _id)
        end

        #def kin_user
        #    redirect_to(root_path) unless redirect_to root_path unless current_user?(Micropost.find(params[:id]).user) or current_user?(Micropost.find(params[:id]).subject) or current_user.friend_with?(Micropost.find(params[:id]).subject) or current_user.friend_with?(Micropost.find(params[:id]).user)
        #end  
end
