class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable # Add modules as needed

  # Additional validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  has_many :comments
end
