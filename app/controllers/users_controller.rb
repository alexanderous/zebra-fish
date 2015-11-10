class UsersController < ApplicationController
  #before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :show, :show_posts] #,
                #which includes -> #only: [:new, :create, :index, :edit, :update, :destroy, :following, :followers, :show, :show_posts, :other_user_index, :story_ticker, :kinships]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy]
  #before_filter :kin,         only: [:show_posts, :anthologies_managed]

  def index
    @users = User.search(params[:search], params[:page])
    #@users = User.order("name").page(params[:page]).per_page(5) #search function from Railscasts
    session[:return_to] = request.referer
    if current_user.dead?
        sign_in current_user.admin
        redirect_to anthologies_path
    end 
  end

  def show
    @user = User.find(params[:id])
    @users = User.search(params[:search], params[:page])
    if current_user.dead?
        sign_in current_user.admin
        redirect_to user_path(@user)
    end 
    @micropost = current_user.microposts.build
    @microposts = @user.microposts
    @drafts = Micropost.where(:user_id => @user.id, :draft => true)
    @publishedcontributions = @user.microposts - @drafts
    @comment_items = Comment.where(:user_id => @user.id)
    @comments = @micropost.comments.all
    #@anthology_items = Micropost.where(:subject_id => @user.id).reorder('dateofevent')
    @anthology_items = Micropost.where(["user_id in (?) or subject_id in (?)", @user.id, @user.id])
    session[:return_to] = request.referer
    @admin = @user.admin
    #@legacy_anthologies = @user.legacy_anthologies.where(:dead => true)
  end

 # def life_story
 #   @user = User.find(params[:id])
  
 # end

  #def randy_provide #why not randy_provide? slightly confused...
    #@user.id = '119'
    #@subject_id = "119"
  #end

  def show_posts 
    @user = User.find(params[:id])
    @users = User.search(params[:search], params[:page])
    @micropost = current_user.microposts.build
    @microposts = @user.microposts.reorder('dateofevent')
    @anthology_items = Micropost.where(:subject_id => @user.id)
    session[:return_to] = request.referer
    @hidden_contributions = current_user.microposts.where(:hide => "true")
  end

  def new
    #if signed_in?
    #  if current_user.dead?
    #    sign_in current_user.admin
    #  end
    #end  
    @user = User.new
    #@users = User.search(params[:search], params[:page]) #took away search function
  end
  
  def create
    env["HTTP_REFERER"] += '#x'

    session[:return_to] ||= request.referer
    @user = User.new(params[:user])
    #if @user.email == "" && @user.dead
    #  @user.email = "legacy@antho.co"
    #end
    if @user.save
      #use this to make first and last names -> @user.first_name, @user.last_name = params[:user][:full_name].split(" ", 2)
      #current_user.invite(@user)
      #@user.approve(current_user) #kinships
      #if @user.dead?
      #  flash[:success] = "Thanks for creating an anthology! As this anthology's creator, you will manage its posts and kinships."
      #else
      #  flash[:success] = "Thanks for creating an anthology! An e-mail will be sent to your friend when you contribute your first story!"
      #end
      sign_in @user
      #flash.now[:alert] = "Thanks for signing up."
      ##redirect_to :back, alert: "Welcome to Antho! You can now contribute to and comment on stories." #@user
      #if :back == michelle_path 
        redirect_to session.delete(:return_to), alert: "Welcome to Antho!"
      #redirect_to michelle_path(anchor: 'post-signup-redirect'), alert: "Welcome to Antho! You can now contribute to Michelle's life story." #@user
      #else 
      #  redirect_to :back, alert: "Welcome to Antho! You can now contribute to and comment on stories." #@user
      #end

    else
      flash.now[:error2] = "Sorry, something went wrong. Please try again."
      #@redosignin = "hello"
      flash.keep
      redirect_to :back
      #render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @users = User.search(params[:search], params[:page])
    if @user.dead? && current_user == @user
        sign_in @user.admin
        redirect_to edit_user_path(@user.admin)
    end 
  end

  def update
    @user = User.find(params[:id])
    #currently a security hole; if ppl leave accounts signed in at public computers
    #people can change their e-mail addresses/pwds without needing to know their current pwd
    #but at least for now people can update photo without entering old or new password
    #need to have new variable called current password -- perhaps use devise/omniauth for greater security
    #below, attempt at hijacking devise methods for users to require inputting pwd when updating email address,
    #but since it doesn't require current password, it's worthless right now.
    #email_changed = @user.email != params[:user][:email]
    #password_changed = !params[:user][:password].empty?
    #successfully_updated = if email_changed or password_changed
          #@user.update_with_password(params[:user])
      #  sign_in @user
      #  flash[:success] = "Information updated"
      #  redirect_to @user
      #else
      #  render 'edit'
      #end
   
    if @user.update_attributes(params[:user])
      if @user.dead?
        flash[:success] = "Information updated"
        redirect_to @user
      else 
        sign_in @user
        flash[:success] = "Information updated"
        redirect_to @user
      end
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  def anthologies_managed
    @user = User.find(params[:id])
    @legacy_anthologies = @user.legacy_anthologies.where(:dead => "true")
    @users = User.search(params[:search], params[:page])
  end

  def self
      @user = current_user
      @users = User.search(params[:search], params[:page])
      if @user.dead?
        sign_in @user.admin
        redirect_to self_path
      end 
      @micropost = current_user.microposts.build
      @drafts = Micropost.where(:user_id => @user.id, :draft => true)
      @publishedcontributions = @user.microposts - @drafts
      @comments = @micropost.comments.all 
      @anthology = current_user.anthology
      @anthology_items = @user.anthology
      @comment_items = @micropost.comments.all
      @legacy_anthologies = @user.legacy_anthologies.where(:dead => true)
  end

  #def kinships
  #  @user = User.find(params[:id])
  #  if @user.dead && current_user == @user.admin
  #    sign_in @user
  #    redirect_to kinships_user_path(@user)
  #  elsif current_user.dead && @user != current_user
  #    sign_in current_user.admin
  #    redirect_to kinships_user_path(@user)
  #  end 
  #  @users = User.search(params[:search], params[:page])
  #  @friends = @user.friends
  #  @pending_requests = @user.pending_invited_by

  #end


  private

    def correct_user
      @user = User.find(params[:id])
      #redirect_to(root_path) unless current_user?(@user) or current_user?(@user.admin)
      redirect_to(:back) unless current_user?(@user) or current_user?(@user.admin)
    end

    def admin_user
      #redirect_to root_path unless current_user.admin?
      redirect_to :back unless current_user.admin?
    end

    #def kin
    #  @user = User.find(params[:id])
    #  redirect_to(root_path) unless current_user.friend_with?(@user) or current_user?(@user)
    #end

end

