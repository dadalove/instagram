class CreateTagships < ActiveRecord::Migration
  def change
    create_table :tagships do |t|
      t.integer :photo_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
