class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :path
      t.string :original_path
      t.integer :original_width
      t.integer :original_height
      t.datetime :date

      t.timestamps null: false
    end
  end
end
