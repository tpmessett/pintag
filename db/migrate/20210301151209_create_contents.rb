class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :name
      t.text :description
      t.text :link

      t.timestamps
    end
  end
end
