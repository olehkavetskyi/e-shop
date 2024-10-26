class CommentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user  # Assuming users are logged in using Devise

    if @comment.save
      redirect_to @product, notice: "Comment posted successfully."
    else
      redirect_to @product, alert: "Comment could not be posted."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
