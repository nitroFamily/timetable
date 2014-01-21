class GroupsController < ApplicationController
  def new
  	
  end

  def show
  	@group = Group.find(params[:id])
  end
end
