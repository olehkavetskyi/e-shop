class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ['user', 'admin'] }

  has_many :comments
  # Associations
  has_one :cart, dependent: :destroy

  after_create :create_cart

  def create_cart
    Cart.create(user: self)
  end

  def admin?
    role == 'admin'
  end

end
