class Content < ApplicationRecord
  has_many :content_tags
  has_many :tags, through: :content_tags
  belongs_to :board
  include PgSearch::Model
  multisearchable against: [name: 'B', description: 'C'], using: [:tsearch]
end
