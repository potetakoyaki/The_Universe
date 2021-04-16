class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follows, class_name: "Follow", foreign_key: "follows_id", dependent: :destroy
  has_many :followed, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follows, source: :followed
  has_many :follower_user, through: :followed, source: :follows
  attachment :image
end
