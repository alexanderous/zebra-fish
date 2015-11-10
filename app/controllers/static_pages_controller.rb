class StaticPagesController < ApplicationController
  before_filter :authenticate, only: [:randy_provide, :randy_protect, :randy_preside, :randy_childhood, :randy_formative_years, 
    :randy_early_adulthood, :randy_timeline, :randy_adventure, :randy_courtship, :randy_family_tree]
  #before_filter :authentication, only: :salmon
  before_filter :restricted, only: [:li_family_tree, :li_grace, :li_guestbook, :li_progress_one, :li_progress_two, :li_progress_three, :li_spirituality, :li_test, :li_timeline]
  before_filter :passwall, only: [:evelyn_hardship, :evelyn_faith, :evelyn_motherhood_1, :evelyn_motherhood_2, :evelyn_purpose, :evelyn_descendants, :evelyn_family_tree, :evelyn_timeline, :evelyn_guestbook]  
  before_filter :carmawall, only: [:carma_childhood_1, :carma_childhood_2, :carma_chocolate, :carma_farmer_and_nurse_1, :carma_farmer_and_nurse_2, :carma_guestbook, :carma_i_can_do_hard_1, :carma_i_can_do_hard_2, :carma_missionary_service_1, :carma_missionary_service_2, :carma_the_farm, :carma_timeline, :carma_town_living]
  before_filter :rooswall, only: [:roos_bills_childhood, :roos_conversion, :roos_devotion, :roos_guestbook, :roos_resilience, :roos_service, :roos_teresas_childhood, :roos_the_army, :roos_timeline, :roos_wisdom]

  def home
    if signed_in?
      @feed_items = current_user.feed#.paginate(:page => params[:page]) #feed! #what limits the feed to 30 posts? 
      @users = User.search(params[:search], params[:page])
      if current_user.dead?
        sign_in current_user.admin
        redirect_to root_path
      end
    end
  end

  def help
    @users = User.search(params[:search], params[:page])
  end

  def about
    @users = User.search(params[:search], params[:page])
  end

  def test_story
  end

  def randy_provide
    #@user = current_user
    #@user = User.find(params[:id])
    if signed_in?
      @micropost = current_user.microposts.build
    end
    #Micropost.where(["user_id in (?) or subject_id in (?) or user_id in (?) or subject_id in (?)", self.friends, self.friends, self, self])
    #@anthology_items = Micropost.where(:subject_id => @user.id).reorder('dateofevent')
    #@feed_items = Micropost.where(["topic in (?)", "randy_vacation"])
    #@anthology_items = Micropost.where(:topic => 'randy_vacations')
  end

  #def feed
    #Micropost.where(["user_id in (?) or subject_id in (?) or user_id in (?) or subject_id in (?)", self.friends, self.friends, self, self])
  #  Micropost.where(["topic in (?)", "randy_vacations"])
  #end

  def anthology
    #Micropost.where(["topic in (?)", "randy_vacations"])
  end

  protected

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
      username == "[redacted]" && password == "[redacted]"
    end

  end

  protected

    def authentication
      authenticate_or_request_with_http_basic do |username, password|
      username == "[redacted]" && password == "[redacted]"
    end

  end

  protected

    def passwall
      authenticate_or_request_with_http_basic do |username, password|
      username == "[redacted]" && password == "[redacted]"
    end

  end

  protected

    def carmawall
      authenticate_or_request_with_http_basic do |username, password|
      username == "[redacted]" && password == "[redacted]"
    end

  end

  protected

    def rooswall
      authenticate_or_request_with_http_basic do |username, password|
      username == "[redacted]" && password == "[redacted]"
    end

  end

  protected


    def restricted
      authenticate_or_request_with_http_basic do |username, password|
      username == "[redacted]" && password == "[redacted]"
    end
  end
  
end


