class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :like, :dislike]
  before_action :set_product, only: [:create]
  before_action :set_section, only: [:create]

  def create
    @product = Product.find(params[:product_id])
    @section = params[:section] || 'default_section'

    # Check if the user has already rated the product (one rating per product per user)
    if @product.comments.exists?(user: current_user) && comment_params[:rating].present?
      respond_to do |format|
        format.js { render 'rating_error' }  # Renders error JS response if rating already exists
      end
      return
    end

    # Build the comment with user and product association
    @comment = @product.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      @product.update_rating! if @comment.rating.present?
      respond_to do |format|
        format.js { render 'comment_create' }  # Renders JS to display the new comment
      end
    else
      respond_to do |format|
        format.js { render 'comment_error' }  # Renders error JS if comment couldn't be saved
      end
    end
  end


  def like
    @comment = Comment.find(params[:id])
    if update_like_status(true)
      respond_to do |format|
        format.js { render 'reaction' }  # Renders reaction.js.erb for AJAX update
      end
    else
      respond_to do |format|
        format.js { render 'reaction_error' }  # Optionally, handle errors with a different partial or message
      end
    end
  end

  def dislike
    @comment = Comment.find(params[:id])
    if update_like_status(false)
      respond_to do |format|
        format.js { render 'reaction' }
      end
    else
      respond_to do |format|
        format.js { render 'reaction_error' }
      end
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :rating)
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
