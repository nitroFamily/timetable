class SessionsController < ApplicationController

	def new
		
	end

	def create
		group = Group.find_by(:email, params[:session][:email].downcase)
		if group && group.authenticate(params[:session][:password])
			# sign_in group
      redirect_to group
		else
			flash.now[:error] = "Неверный email/пароль" # Not quite right!
      render 'new'
		end
	end

	def destroy
		
	end
end
