module SessionsHelper

	def log_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.digest(remember_token))
		self.current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(User.digest(cookies[:remember_token]))
	end

	def current_user=(user)
		@current_user = user 
	end

	def log_out
		current_user.update_attribute(:remember_token, User.new_remember_token)
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def require_login
		puts "This is being run..."
		unless logged_in?
  		flash[:danger] = "You must be logged in to access this section"
  		redirect_to login_path
  	end
  end

  def logged_in?
  	!current_user.nil?
  end

end
