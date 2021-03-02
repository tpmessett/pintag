class Board < ApplicationRecord
  has_many :contents
  has_many :board_permissions
  belongs_to :user
end
