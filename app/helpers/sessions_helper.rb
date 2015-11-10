module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  #def place=(place)
  #  @place == place 
  #end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def store_location
    session[:return_to] = request.referer
  end

  #def redirect_back_or#(default)
  #  redirect_to session.delete(:return_to) #[:return_to] || default)
    #session.delete(:return_to)
  #end

  #def redirect_workaround
  #  redirect_to :back || root_page
 # end

  def signed_in_user
    unless signed_in?
      #store_location
      flash.now[:error] = "Please sign in to view that page."
      flash.keep
      redirect_to :back
    end
  end
end
