class Post < ApplicationRecord
   attachment :image
   belongs_to :user
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :tags,dependent: :destroy
   

   validates :body, presence: true,  length: {maximum: 100, minimum: 10}
   validates :image, presence: true

   def favorited_by?(user)
     favorites.where(user_id: user.id).exists?
   end
end
