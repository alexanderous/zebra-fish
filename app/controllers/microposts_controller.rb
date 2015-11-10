class MicropostsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy, :edit, :update]
  #before_filter :authorized_user, only: :show

  def index
    if current_user.dead?
        sign_in current_user.admin
    end 
    @drafts = Micropost.where(:draft => true, :user_id => current_user.id)
    @newpublished = Micropost.where(:draft => false, :user_id => current_user.id) 
    @oldpublished = Micropost.where(:draft => nil, :user_id => current_user.id)
    @published = @newpublished + @oldpublished
    @user = current_user
  end

  def show
     session[:return_to] = request.referer
     @micropost = Micropost.find(params[:id])
     @anthology_item = Micropost.find(params[:id])
     @comment = @anthology_item.comments.all
     @user = current_user
     @lovers = @anthology_item.lovers
     @users = User.search(params[:search], params[:page])
  end

  def new
    if current_user.dead?
        sign_in current_user.admin
    end 
    @micropost = current_user.microposts.build(params[:micropost])
        @user = current_user
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])  
    if params[:draft_button]
      @micropost.update_attributes(:draft => true) 
      @micropost.save
      flash[:success] = "Story saved as draft!"
      redirect_to my_drafts_path
    elsif params[:publish_button] 
      @micropost.update_attributes(:draft => false)
      @micropost.update_attributes(:created_at => Time.now) 
      @micropost.save
      flash[:success] = "Thank you for contributing!"
      @subject = @micropost.subject
      #@anthology_items = Micropost.where(:subject_id => @subject.id)
      redirect_to micropost_path(@micropost)
      #if !@subject.dead? && @anthology_items.count < 2
      #    @inviter = current_user #may be useless
          #UserMailer.send_invite(@micropost.id) ## to test in development mode
      #    InvitationsWorker.perform_async(@micropost.id)
      #elsif !@subject.dead? && @anthology_items.count > 1 
          ##UserMailer.notify(@micropost.id).deliver ## to test in development mode
      #    NotificationsWorker.perform_async(@micropost.id)
      #end
    else
      redirect_to :back #contribute_path
    end
  end

  def edit
     @micropost = Micropost.find(params[:id])   
  end
  
  def update
    @micropost = Micropost.find(params[:id])
    if params[:draft_button]
      @micropost.update_attributes(params[:micropost])
      @micropost.update_attributes(:draft => true) 
      flash[:success] = "Story saved as draft!"
      redirect_to drafts_path 
    elsif @micropost.update_attributes(params[:micropost])
      @micropost.update_attributes(:draft => false) 
      flash[:success] ='Story was successfully edited.' 
      @subject_id = @micropost.subject_id
      redirect_to @micropost
    else
      render 'edit'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    flash[:success] ='Story was scrapped.' 
    redirect_to root_path
  end

  def loving?(micropost)
    loves.find_by_loved_id(micropost.id)
  end

  def love!(micropost)
    loves.create!(loved_id: micropost.id)
  end

  def unlove!(micropost)
    loves.find_by_loved_id(micropost.id).destroy
  end
    
  def lovers
    @title = "Lovers"
    @micropost = Micropost.find(params[:id])
    @users = @micropost.lovers
    render 'show_lovers'
  end
  

  private

    def correct_user
         Micropost.find(params[:id]).user_id && Micropost.find(params[:id]).subject_id
         if !Micropost.find(params[:id]).subject.nil?
            if Micropost.find(params[:id]).subject.dead? 
              Micropost.find(params[:id]).subject.admin_id
            end
         end
    end

    #def authorized_user
    #  redirect_to root_path unless current_user?(Micropost.find(params[:id]).user) or current_user?(Micropost.find(params[:id]).subject) or current_user.friend_with?(Micropost.find(params[:id]).subject) or current_user.friend_with?(Micropost.find(params[:id]).user)
    #end

end