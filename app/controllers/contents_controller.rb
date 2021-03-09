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
    tags = find_or_create_tag
    if Tag.where(id: tags)
      @content.tags = Tag.where(id: tags)
      raise
      if @content.save
        redirect_to board_path(@board)
      else
        render :new
      end
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
    policy_scope(Tag)
    @tags = Tag.all
    find_content
    authorize @content
  end

  def update
    find_content
    authorize @content
    tags = find_or_create_tag
    @content.tags = Tag.where(id: tags)
    @content.update(content_params)
    redirect_to board_path(@content.board)
  end

  def find_content
    @content = Content.find(params[:id])
  end

  def find_or_create_tag
    tags = []
    if params[:content][:tags].present?
      input_tags = params[:content][:tags].reject(&:blank?)
    else
      input_tags = params[:content][:tag_ids].reject(&:blank?)
    end
    input_tags.each do |input|
      tag = Tag.where(id: input.to_i).first
      if tag.present?
        tags << tag.id
      else
        new_tag = Tag.create(name: input, user: current_user)
        tags << new_tag.id
      end
    end
    return tags
  end

  private

  def content_params
    params.require(:content).permit(:name, :description, :link, :file_upload)
  end
end
