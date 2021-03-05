class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @tags = Tag.all
    @contents = @board.contents

    if params[:searchtype] == "all"
      @contents = PgSearch.multisearch(params[:search])

      @contents = Content.where(id: @contents.pluck(:searchable_id))

    elsif params[:searchtype] == "tag"
      @tags = @tags.where(name: (params[:search]))
      @contents = Content.joins(:content_tags).where(content_tags: {tag_id: @tags.ids})
    elsif params[:searchtype] == "current-board"
      @contents = PgSearch.multisearch(params[:search])
      @contents = @board.contents.where(id: @contents.pluck(:searchable_id))
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    @board.update(board_params)
    redirect_to board_path(@board)
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end
end
