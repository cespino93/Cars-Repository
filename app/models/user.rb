class User < ApplicationRecord
has_many :posts
has_many :comments
has_many :commented_posts, through :comments,
 source: :post


end
