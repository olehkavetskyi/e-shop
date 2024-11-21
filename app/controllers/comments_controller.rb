class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :like, :dislike]
  before_action :set_product, only: [:create, :like, :dislike]
  before_action :set_section, only: [:create]

  def create
    @section = params[:section] || 'default_section'

    # Build the comment with user and product association
    @comment = @product.comments.build(comment_params.merge(user: current_user))

    # Check if it's a reply and set the parent_id
    @comment.parent_id = params[:comment][:parent_id] if params[:comment][:parent_id].present?

    if @comment.save
      @product.update_rating! if @comment.rating.present?
      respond_to do |format|
        format.js { render 'comment_create' } # Render JS to display the new comment
      end
    else
      respond_to do |format|
        format.js { render 'comment_error' } # Render error JS if comment couldn't be saved
      end
    end
  end

  def like
    @comment = Comment.find(params[:id])
    existing_like = @comment.comment_likes.find_by(user: current_user)

    if existing_like.nil? || existing_like.like != true
      # Add or update like status
      existing_like = @comment.comment_likes.find_or_initialize_by(user: current_user)
      existing_like.update(like: true)
    end

    respond_to do |format|
      format.js { render 'reaction' }
    end
  end

  def dislike
    @comment = Comment.find(params[:id])
    existing_dislike = @comment.comment_likes.find_by(user: current_user)

    if existing_dislike.nil? || existing_dislike.like != false
      # Add or update dislike status
      existing_dislike = @comment.comment_likes.find_or_initialize_by(user: current_user)
      existing_dislike.update(like: false)
    end

    respond_to do |format|
      format.js { render 'reaction' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :rating, :parent_id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_section
    @section = params[:section] || 'default_section'
  end

  def redirect_with_alert(message)
    redirect_to show_product_products_path(section: @section, id: @product.id), alert: message
  end

  def redirect_with_notice(message)
    redirect_to show_product_products_path(section: @section, id: @product.id), notice: message
  end

  def update_like_status(like_status)
    existing_like = @comment.comment_likes.find_or_initialize_by(user: current_user)
    if existing_like.new_record? || existing_like.like != like_status
      existing_like.update(like: like_status)
      true
    else
      false
    end
  end
end
