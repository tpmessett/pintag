class Board < ApplicationRecord
  has_many :contents
  has_many :board_permissions
end
