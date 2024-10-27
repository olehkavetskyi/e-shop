class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable # Add modules as needed
  # Additional validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_many :comments
  # Associations
  has_one :cart, dependent: :destroy

  after_create :create_cart

  private

  def create_cart
    Cart.create(user: self)
  end

end
