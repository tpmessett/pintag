class Content < ApplicationRecord
  has_many :content_tags
  has_many :tags, through: :content_tags
  belongs_to :board
end
