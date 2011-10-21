class RootController < ApplicationController
  before_filter :authenticate_user!, :set_as_logged_in
  
  def index
  end

  def status
    @digest_changed = User.digest != params[:digest]
		if @digest_changed
      render :json => {
        changed: true,
        users: [current_user] + (User.ordered - [current_user]),
        current_user: current_user,
        digest: User.digest
      }
    else
      render :json => { changed: false }
    end
  end

  def set_as_logged_in
		current_user ? current_user.online! : current_user.offline!
  end

end
