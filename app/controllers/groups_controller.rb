class GroupsController < ApplicationController
  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(group_params)
  	if @group.save
      sign_in @group
  		flash[:success] = "Аккаунт вашей группы успешно создан"
  		redirect_to @group
  	else
  		render 'new'
  	end
  end

  def show
  	@group = Group.find(params[:id])
  end

  private
  def group_params
  	params.require(:group).permit(:name, :email, :password, :password_confirmation)
  end
end
