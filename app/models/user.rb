class User < ApplicationRecord
has_many :posts
has_many :comments
has_many :commented_posts, through: :comments, source: :post
has_secure_password 
has_many :brands, through: :posts

validates :username, :email, presence: true

def self.most_active
    joins(:posts).group(:user_id).order("count(user_id) DESC").limit(3)
end
end
