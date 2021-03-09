class TagsController < ApplicationController
  def new
    @content = Content.find(params[:id])
    @tag = Tag.new
    authorize @tag
  end

  def create
    @tag = tag_exists
    @content = Content.find(params[:id])
    @content_tag = ContentTag.new
    @content_tag.content = @content
    @content_tag.tag = @tag
    authorize @tag
    if @content_tag.save
      redirect_to board_path(@content.board_id)
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
    authorize @tag
  end

  def update
    @tag = Tag.find(params[:id])
    authorize @tag
    @tag.update(tag_params)
    redirect_to tag_path(@tag)
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize @tag
    @tag.destroy
    redirect_to tags_path
  end

  private

  def tag_exists
    if Tag.where(name: params[:tag][:name]).present?
      Tag.find_by(params[:name])
    else
      @tag = Tag.new(tag_params)
      @tag.user = current_user
      @tag.save
      @tag
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
