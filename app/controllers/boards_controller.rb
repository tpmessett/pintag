class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    @boards = policy_scope(Board)
    @shared_boards = current_user.shared_boards
    @photos = generate_photos
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
    client = Slack::Web::Client.new
    channels = client.conversations_list.channels
    @channel_names = []
    channels.each { |channel| @channel_names << channel.name_normalized}
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
    @board = Board.find(params[:id])
    authorize @board
    params[:user_id].each do |id|
      BoardPermission.create(board_id: params[:id], user_id: id)
    end
    redirect_to board_path(params[:id]), notice: "Board shared successfully"
  end

  def send_to_slack
    client = Slack::Web::Client.new
    @channel = params[:channel]
    @message = params[:message]
    @board = Board.find(params[:board_id])
    @text = "#{current_user.email} shared #{@board.name}, from https://pintag.app#{board_path @board} with the message: #{@message}"
    authorize @board

    client.chat_postMessage(channel: @channel, text: @text, as_user: true)
    redirect_to board_path(@board), notice: "Successfully shared to Slack"
  end

  def generate_photos
    unsplash = Unsplash::Photo.random(count: 5, query: "startup&w=200")
    photos = []
    unsplash.each do |photo|
      photos << photo.urls.raw
    end
    photos.unshift("https://media-exp1.licdn.com/dms/image/C4D1BAQGNAwJ6d_6e8w/company-background_10000/0/1546601904957?e=2159024400&v=beta&t=BCCklNZAZS8uO2z-N3jACcleH4ytQwtPwABd8l0VXac")
    photos.unshift("http://servicingstopvw.co.uk/wp-content/uploads/2017/11/VW1.jpg")
    photos.unshift("https://moosend.com/wp-content/uploads/2020/07/Instagram-influencer-marketing.png")
    photos.unshift("https://i.insider.com/5e4c03d32dae5c4bf412139b?width=1136&format=jpeg")
    return photos
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
