class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :like, :dislike]

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to @product, notice: "Comment posted successfully."
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
    params.require(:comment).permit(:content)
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
