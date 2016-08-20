class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :username, presence: true, length: { minimum: 4, maximum: 25 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
