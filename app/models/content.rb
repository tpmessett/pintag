class Content < ApplicationRecord
  has_many :content_tags, dependent: :destroy
  has_many :tags, through: :content_tags
  belongs_to :board
  has_one_attached :file_upload
  include PgSearch::Model
  multisearchable against: [:name, :description], using: [:tsearch]
  validates :file_upload, presence: true, unless: :link

  validate :file_or_link

  def file_or_link
    errors.add(:alert, "Either file_upload or link needs a value") unless file_upload.present? || link.present?
  end
end
