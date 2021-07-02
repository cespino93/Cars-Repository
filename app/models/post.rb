class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :comments
  has_many :users, through :comments
end
