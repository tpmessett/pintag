class ContentsController < ApplicationController
  def new
    @content = Content.new
    @board = Board.find(params[:board_id])
    @tags = policy_scope(Tag)
    authorize @content
  end

  def create
    @board = Board.find(params[:board_id])
    @content = Content.new(content_params)
    @content.board = @board
    authorize @content
    tags = params[:content][:tags].reject(&:blank?).map(&:to_i)
    @content.tags = Tag.where(id: tags)
    if @content.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def show
    authorize @content
    find_content
    @file_name = @content.file_upload.filename.to_s.match(/^([^.]+)/)
  end

  def destroy
    find_content
    board = @content.board
    authorize @content
    @content.destroy
    redirect_to board_path(board)
  end

  def edit
    find_content
    authorize @content
  end

  def update
    find_content
    authorize @content
    @content.update(content_params)
    redirect_to board_path(@content.board)
  end

  def find_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:name, :description, :link, :file_upload)
  end
end
