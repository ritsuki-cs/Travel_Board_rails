class Micropost < ApplicationRecord
  belongs_to :user
  has_many :micropost_tag_relations, dependent: :destroy
  has_many :tags, through: :micropost_tag_relations
  has_many_attached :images
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validates :images,   presence: true, content_type: { in: %w[image/jpeg image/gif image/png],
                                                      message: "must be a valid image format" },
                                      size:         { less_than: 5.megabytes,
                                                      message: "should be less than 5MB" }
  validates :lat,     presence: true
  validates :lng,     presence: true
  validates :address, presence: true
  
  # 表示用のリサイズ済み画像を返す
  def display_image(image)
    image.variant(resize_to_limit: [200, 200])
  end
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end
end
