class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :comment_likes, dependent: :destroy
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy

  def likes_count
    comment_likes.where(like: true).count
  end

  def dislikes_count
    comment_likes.where(like: false).count
  end

  validates :content, presence: true
end

