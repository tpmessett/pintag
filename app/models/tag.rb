class Tag < ApplicationRecord
  has_many :content_tags, dependent: :destroy
  has_many :contents, through: :content_tags
  belongs_to :user
end
