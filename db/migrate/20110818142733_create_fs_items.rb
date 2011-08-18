class CreateFsItems < ActiveRecord::Migration
  def self.up
    create_table :fs_items do |t|
      t.string :name
      t.string :path
      t.integer :parent_id
      t.timestamps
    end
    add_index(:fs_items, [:parent_id, :name], :unique => true)
  end

  def self.down
    drop_table :fs_items
  end
end
