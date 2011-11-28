class AddRateToBookmarks < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :rate, :integer, :null => false, :default => 3
  end

  def self.down
    remove_column :bookmarks, :rate
  end
end
