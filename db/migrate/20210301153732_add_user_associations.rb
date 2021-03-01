class AddUserAssociations < ActiveRecord::Migration[6.0]
  def change
    add_reference :boards, :user, null: false, foreign_key: true
    add_reference :tags, :user, null: false, foreign_key: true
    add_reference :board_permissions, :user, null: false, foreign_key: true
  end
end
