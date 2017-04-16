class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    #this is in the browser session
    session[:user_id] = user.id
    #this is in the DB session
    my_session = Session.new
    my_session.user_id = user.id
    my_session.save
    UpdateUserInfo.run(user)
    redirect_to root_url, :alert => "Signed in!"
  end
 
  def destroy
    User.find(session[:user_id]).session.destroy
    session[:user_id] = nil
    redirect_to root_url, :alert => "Signed out!"
  end
end
