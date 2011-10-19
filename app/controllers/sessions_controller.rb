class SessionsController < Devise::SessionsController

  def destroy
		current_user.offline!
    super
  end
  
end
