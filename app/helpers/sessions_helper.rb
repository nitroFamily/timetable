module SessionsHelper
	def sign_in(group)
		remember_token = Group.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    group.update_attribute(:remember_token, Group.encrypt(remember_token))
    self.current_group = group
	end

	def current_group=(group)
		@current_group = group
	end

	def current_group 
		remember_token = Group.encrypt(cookies[:remember_token])
		@current_group ||= Group.find_by(remember_token: remember_token)
	end

	def current_group?(group)
    group == current_group
  end

	def signed_in?
		!current_group.nil?
	end

	def signed_in_group
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Пожалуйста войдите" 
    end
  end

	def sign_out
		current_group.update_attribute(:remember_token, Group.encrypt(Group.new_remember_token))
		cookies.delete(:remember_token)
		self.current_group = nil
	end

	def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
