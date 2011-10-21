class UsersController < ApplicationController

  def index
		current_user.update_attribute :rtsp_url, params[:url]
    render :text => params[:url]
  end
  
end
