class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    @boards = policy_scope(Board)
    @shared_boards = current_user.shared_boards
    @photos = Unsplash::Photo.random(count: 10, query: "startup&w=200")
  end

  def new
    @board = Board.new
    authorize @board
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    authorize @board
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
   
    authorize @board 
     if params[:extension_filter].present?
      @contents = @contents.select do | content |
        if content.file_upload.attached?
         content.file_upload.content_type.include?(params[:extension_filter][:extension])
        elsif content.link?
          params[:extension_filter][:extension] == "link"
        else 
          next
        end
      end
     end
    
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
    authorize @board
  end

  def update
    @board = Board.find(params[:id])
    authorize @board
    @board.update(board_params)
    redirect_to board_path(@board)
  end

  def destroy
    @board = Board.find(params[:id])
    authorize @board
    @board.destroy
    redirect_to boards_path
  end

  def share
    params[:user_id].each do |id|
      BoardPermission.create(board_id: params[:id], user_id: id)
    end
    redirect_to board_path(params[:id]), notice: "shared"
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
