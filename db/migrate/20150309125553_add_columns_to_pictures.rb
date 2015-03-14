class AddColumnsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :iine_count, :integer
    add_column :pictures, :total_count, :integer
    add_column :pictures, :choosed, :boolean
  end
end
