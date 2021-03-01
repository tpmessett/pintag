class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :board_permissions
  has_many :boards
  has_many :tags
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
