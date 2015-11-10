class SessionsController < ApplicationController

  def new #doesn't work?
  end

  def create
    env["HTTP_REFERER"] += '#x'

    session[:return_to] ||= request.referer#(anchor: @place)#(params[:place]) 
    #request.referer(anchor: "@identity_@place")
    user = User.find_by_login(params[:session][:login])
      #store_location
    if user && user.authenticate(params[:session][:password])   
      sign_in user
      #if user.microposts.count < 5
        #flash[:success] = "Hey there! Check out some of the most recent stories of your kin here at the Museum!"
        #redirect_to root_path
        #redirect_back_or#(:back) #doesn't work?
        
        #session[:return_to] ||= request.referer
        #return Redirect::intended('defaultpageafterlogin');
        #@redosignin = current_user
        #flash.now[:notice] = "Welcome back to Antho!"
        ###redirect_to :back, alert: "Welcome back to Antho!"
        #flash.now[:notice] = "Welcome back to Antho!"
        #redirect_workaround
        #redirect_to :back or redirect_to root_path #for home page sign ins, that UI should also be a pop up window!!!!
        #window.location = 'pathToCurrentPage'
      #elsif user.friends.count < 5 
        #flash[:success] = "Welcome Back! Explore the collection of anthologies and add some kin, or start an anthology for someone new!"
        #redirect_to anthologies_path
      #else
        #redirect_to root_path
      #end
      #if user.id > 50 #:back == michelle_path 
        redirect_to session.delete(:return_to), alert: "Welcome back to Antho!" #+ "@place" 
        #past #redirect_to michelle_path(anchor: 'post-signup-redirect'), alert: "Welcome back to Antho! You can now contribute to Michelle's life story." #@user
      #else 
      #  redirect_to :back, alert: "Welcome back to Antho!"
      #end

    else
      
      #flash.now[:error] = "Sorry, but either your username or password is wrong! Your username is case-sensitive."
      #flash.now[:error] = "Sorry, but either your username or password is wrong! Your username is case-sensitive."
      #flash.now[:error] = "Sorry, but either your username or password is wrong! Your username is case-sensitive."
      flash.now[:error] = "Sorry, but either your username or password is wrong! Your username is case-sensitive."
      #@redosignin = "hello"
      flash.keep
      redirect_to :back#, alert: "Sorry, but either your username or password is wrong! Your username is case-sensitive."
      #redirect_to :back 
      #render '#myModal'
      #render :partial => 'shared/modal_login'
      #render 'new'


    end
  end

  def destroy
    #session[:return_to] ||= request.referer
    sign_out

    #redirect_to session.delete(:return_to)
    redirect_to root_path #tried doing :back, but for some reason it doesn't work when I sign out of :drafts.
  end
end
