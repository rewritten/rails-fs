class AddDescriptionToFsItem < ActiveRecord::Migration
  def self.up
    add_column :fs_items, :description, :text
  end

  def self.down
    remove_column :fs_items, :description
  end
end
