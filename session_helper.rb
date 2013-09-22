helpers do

  def start_session(user)
    session[:user_id] = user.id
  end

  def login(email, password)
    user = User.find_user_by_email_and_password(email, password)
    start_session(user) unless user.nil?
  end

  # def logout
  #   sesssion.clear
  # end

  def logged_in?
    user = User.find_by_id(session[:user_id])
    !user.nil?
  end

  def get_user_from_session
    User.find(session[:user_id])
  end
  
  def logout
    session = {}
  end
end