class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
  validates :post, uniqueness: {scope: :user_id, message: "You can only have one comment per user"}
end
