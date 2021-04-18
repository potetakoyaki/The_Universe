class Post < ApplicationRecord
   attachment :image
   belongs_to :user
   has_many :post_comments
   has_many :favorites

   validates :title, presence: true, length: {maximum: 20, minimum: 2}
   validates :body, presence: true,  length: {maximum: 100, minimum: 20}
   validates :image, presence: true

   def favorited_by?(user)
     favorites.where(user_id: user.id).exists?
   end
end
