class LovesController < ApplicationController
  before_filter :signed_in_user

  def create
  	@micropost = Micropost.find(params[:love][:loved_id])
  	current_user.love!(@micropost)
  	respond_to do |format|
  		format.html { redirect_to @micropost }
  		format.js { render :layout=>false, :content_type => 'application/javascript' }
  	end
  end

  def destroy
  	@micropost = Love.find(params[:id]).loved
  	current_user.unlove!(@micropost)
  	respond_to do |format|
  		format.html { redirect_to :back }
  		format.js { render :layout=>false, :content_type => 'application/javascript' }
  	end
  end
end
