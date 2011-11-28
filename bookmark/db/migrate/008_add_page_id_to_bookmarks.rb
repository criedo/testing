class AddPageIdToBookmarks < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :page_id, :integer
  end

  def self.down
    remove_column :bookmarks, :page_id
  end
end
