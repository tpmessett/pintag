class ContentsController < ApplicationController
  def new
    @content = Content.new
    @board = Board.find(params[:board_id])
  end

  def create
    @board = Board.find(params[:board_id])
    @content = Content.new(content_params)
    if @content.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to contents_path
  end

  def booking_params
    params.require(:content).permit(:name, :description, :link, :board_id)
  end
end
