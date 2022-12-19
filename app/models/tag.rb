class Tag < ApplicationRecord
  has_many :micropost_tag_relations, dependent: :destroy
  has_many :microposts, through: :micropost_tag_relations
  
  validates :name, uniqueness: true
end
