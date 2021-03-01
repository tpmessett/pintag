class CreateBoardPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :board_permissions do |t|

      t.timestamps
    end
  end
end
