class Post < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :comments
  has_many :users, through: :comments
  validates :content, :title, presence: true
  validate  :too_many_posts

  delegate :name, to: :brand

  scope :alpha, -> { order(:title) }
  scope :most_comments, -> {left_joins(:comments).group('posts.id').order('count(comments.post_id) desc')}

  def self.filter(params)
    where("category_id = ?", params)
  end

  def self.search(params)
    left_joins(:comments).where("LOWER(posts.title) LIKE :term OR LOWER(posts.content) LIKE :term OR LOWER(comments.content) LIKE :term", term: "%#{params}%")
  end

  def brand_attributes=(attr)
    self.brand = Brand.find_or_create_by(attr) if !attr[:name].blank?
  end

  def too_many_posts
    today_posts = user.posts.select do |p|
      p.created_at.try(:to_date) == Date.today
  end

  if today_posts.size > 9
    errors.add(:post_id, "- can't post more than 10 times per day.")
  end
end

end
