class ContentsController < ApplicationController
  def new
    @content = Content.new
    @board = Board.find(params[:board_id])
    @tags = Tag.all
  end

  def create
    @board = Board.find(params[:board_id])
    @content = Content.new(content_params)
    @content.board = @board
    tags = params[:content][:tags].reject(&:blank?).map(&:to_i)
    @content.tags = Tag.where(id: tags)
    if @content.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def show
    find_content
  end

  def destroy
    find_content
    board = @content.board
    @content.destroy
    redirect_to board_path(board)
  end

  def edit
    find_content
  end

  def update
    find_content
    @content.update(content_params)
    redirect_to board_content_path(@content.board.id, @content.id)
  end

  def find_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:name, :description, :link, :file_upload)
  end
end
