class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :like, :dislike]

  def create
    @product = Product.find(params[:product_id])

    # Check if the user has already commented and rated the product
    existing_comment = @product.comments.find_by(user: current_user)
    if existing_comment
      redirect_to @product, alert: "You have already rated and commented on this product."
      return
    end

    # Build comment with rating
    @comment = @product.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      # Update product's average rating if a rating is provided
      if @comment.rating.present?
        @product.update_average_rating!
      end
      redirect_to @product, notice: "Comment and rating posted successfully."
    else
      redirect_to @product, alert: "Comment could not be posted."
    end
  end

  def like
    @comment = Comment.find(params[:id])
    like_dislike_comment(@comment, true)
  end

  def dislike
    @comment = Comment.find(params[:id])
    like_dislike_comment(@comment, false)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :rating)
  end

  def like_dislike_comment(comment, like_status)
    existing_like = comment.comment_likes.find_by(user: current_user)

    if existing_like
      existing_like.update(like: like_status)
    else
      comment.comment_likes.create(user: current_user, like: like_status)
    end

    redirect_to comment.product, notice: "Your reaction has been recorded."
  end
end
