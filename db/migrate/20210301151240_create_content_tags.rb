class CreateContentTags < ActiveRecord::Migration[6.0]
  def change
    create_table :content_tags do |t|

      t.timestamps
    end
  end
end
