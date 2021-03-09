class Api::V1::ContentsController < Api::V1::BaseController

  def create
    @board = Board.find(params[:board_id])
    @content = Content.new(content_params)
    @content.board = @board
    authorize @content
    tags = find_or_create_tag
    if Tag.where(id: tags)
      @content.tags = Tag.where(id: tags)
      if @content.save
        render json: {
          message: "success"
        }, status: 201
      else
        render_error
      end
    end
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

  def show
    @content = Content.find(params[:id])
    authorize @content
  end

private

  def content_params
    params.require(:content).permit(:name, :description, :link, :file_upload)
  end

end
