class LessonsController < ApplicationController
  before_action :signed_in_group

  def new
  	@lesson = current_group.lessons.build if signed_in?
  end

  def create
  	@lesson = current_group.lessons.build(lesson_params)
  	if @lesson.save
  		flash[:success] = "Создан"
  		redirect_to group_path(current_group)
  	else
  		render 'new'
  	end
  end

  def edit
  	@lesson = current_group.lessons.find(params[:id])
  end

  def update
  	@lesson = current_group.lessons.find(params[:id])
  	if @lesson.update_attributes(lesson_params)
  		flash[:success] = "Обнавлен"
  		redirect_to group_path(current_group)
  	else
  		render 'edit'
  	end
  end

  def destroy
  	current_group.lessons.find(params[:id]).destroy
    flash[:success] = "удалена"
    redirect_to group_path(current_group)
  end

  private
    def lesson_params
      params.require(:lesson).permit(:name,
      															 :form,
      															 :number,
      															 :classroom,
      															 :day,
      															 :start_week,
      															 :end_week)
    end
end