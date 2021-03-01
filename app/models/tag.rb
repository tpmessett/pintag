class Tag < ApplicationRecord
  has_many :content_tags
  belongs_to :user
end
