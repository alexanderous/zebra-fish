class EvangelistsController < ApplicationController
  before_filter :authenticate2, only: :index

  def index
    @evangelists = Evangelist.all
  end

  def new
  	@evangelist = Evangelist.new(params[:evangelist])
  end

  def create
    @evangelist = Evangelist.new(params[:evangelist])
    if @evangelist.save
      flash[:success] = "Thanks for contacting us! We'll get back to you within 1 business day!"
      redirect_to root_url
      EvangelistsWorker.perform_async(@evangelist.id)
    else
      render 'new'
    end    
  end

  protected

    def authenticate2
      authenticate_or_request_with_http_basic do |username, password|
      username == "antho" && password == "graphica"
    end
  end

end
