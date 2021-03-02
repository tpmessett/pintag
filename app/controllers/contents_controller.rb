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
    @content = Content.find(params[:id])
  end

  def destroy
    find_content
    @content.destroy
    redirect_to contents_path
  end

  def edit
    find_content
  end

  def update
    find_content
    @content.update(content_params)
    redirect_to content_path(@content)
  end

  def find_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:name, :description, :link)
  end
end
