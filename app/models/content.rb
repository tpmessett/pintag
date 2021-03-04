class Content < ApplicationRecord
  has_many :content_tags, dependent: :destroy
  has_many :tags, through: :content_tags
  belongs_to :board
  has_one_attached :file_upload
  include PgSearch::Model
  multisearchable against: [:name, :description], using: [:tsearch]

end
