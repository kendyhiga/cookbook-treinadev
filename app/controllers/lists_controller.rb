class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      flash[:notice] = 'Lista cadastrada com sucesso'
      redirect_to @list
    else
      flash.now[:failure] = 'Não foi possível salvar a lista'
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
