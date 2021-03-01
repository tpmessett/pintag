class BoardAssociations < ActiveRecord::Migration[6.0]
  def change
    add_reference :contents, :board, null: false, foreign_key: true
    add_reference :board_permissions, :board, null: false, foreign_key: true
  end
end
