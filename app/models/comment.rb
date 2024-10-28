class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :comment_likes, dependent: :destroy

  def likes_count
    comment_likes.where(like: true).count
  end

  def dislikes_count
    comment_likes.where(like: false).count
  end

  validates :content, presence: true
end
