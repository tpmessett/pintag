class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :board_permissions
  has_many :shared_boards, through: :board_permissions, source: :board
  has_many :boards
  has_many :tags
  has_one_attached :photo

end
