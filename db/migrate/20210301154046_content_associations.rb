class ContentAssociations < ActiveRecord::Migration[6.0]
  def change
    add_reference :content_tags, :content, null: false, foreign_key: true
  end
end
