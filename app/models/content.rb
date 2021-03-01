class Content < ApplicationRecord
  has_many :content_tags
  belongs_to :board
end
