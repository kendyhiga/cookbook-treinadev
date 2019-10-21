# frozen_string_literal: true

# Lists Controller
class ListsController < ApplicationController
  def new
    redirect_to new_user_session_path unless user_signed_in?
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:notice] = (t 'list_registered_successfully')
      redirect_to @list
    else
      flash.now[:failure] = (t 'list_registered_unsuccessfully')
      render :new
    end
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
