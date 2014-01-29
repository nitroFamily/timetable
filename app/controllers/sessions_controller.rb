class SessionsController < ApplicationController

	def new
		
	end

	def create
		group = Group.find_by(email: params[:session][:email].downcase)
		if group == group.authenticate(params[:session][:password])
			sign_in group
			redirect_back_or group
		else
			flash.now[:error] = "Неверный email/пароль"
      render 'new'
		end
	end

	def destroy
		sign_out
    redirect_to root_url
	end
end
