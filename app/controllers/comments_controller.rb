class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :like, :dislike]
  before_action :set_product, only: [:create]
  before_action :set_section, only: [:create]

  def create
    # Create a comment with optional rating and parent comment (for replies)
    @comment = @product.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      @product.update_rating! if @comment.rating.present? # Update product rating if a rating is provided
      redirect_with_notice("Comment posted successfully.")
    else
      redirect_with_alert("Comment could not be posted.")
    end
  end

  def like
    update_like_status(true)
    respond_to do |format|
      format.html { redirect_to @comment.product, notice: "Your like has been recorded." }
      format.js { render 'reaction' }
    end
  end

  def dislike
    update_like_status(false)
    respond_to do |format|
      format.html { redirect_to @comment.product, notice: "Your dislike has been recorded." }
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
    @comment = Comment.find(params[:id])
    existing_like = @comment.comment_likes.find_or_initialize_by(user: current_user)

    if existing_like.new_record? || existing_like.like != like_status
      existing_like.update(like: like_status)
      notice = "Your reaction has been recorded."
    else
      notice = "Your reaction is already recorded as #{like_status ? 'like' : 'dislike'}."
    end

    redirect_to @comment.product, notice: notice
  end
end
