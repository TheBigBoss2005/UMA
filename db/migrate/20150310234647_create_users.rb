class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    'name', null: false
      t.string    'icon'
      t.integer   'selection_count',  default: 0

      t.timestamps null: false
    end
  end
end
