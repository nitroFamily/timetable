class GroupsController < ApplicationController
  before_action :signed_in_group, only: [:edit, :update, :destroy]
  before_action :correct_group,   only: [:edit, :update]
  before_action :admin_group,     only: :destroy

  def index
    @group = Group.paginate(page: params[:page])
  end

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
    @week = params[:week]
    @lessons = get_lessons(@week)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "Профиль обновлен"
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = "Группа удалена"
    redirect_to groups_url
  end

  def correct_group
    @group = Group.find(params[:id])
    redirect_to(root_url) unless current_group?(@group)
  end

  def admin_group
    redirect_to(root_url) unless current_group.admin?
  end

  private
  def group_params
  	params.require(:group).permit(:name, :email, :password, :password_confirmation)
  end
end
