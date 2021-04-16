class Follow < ApplicationRecord
  belongs_to :follows, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follows_id, presence: true
  validates :followed_id, presence: true
end
