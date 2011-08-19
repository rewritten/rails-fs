class AddTypeStiToFsItem < ActiveRecord::Migration
  def self.up
    add_column :fs_items, :type, :string
  end

  def self.down
    remove_column :fs_items, :type
  end
end
