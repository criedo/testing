class AddCategoryIdToBookmarks < ActiveRecord::Migration
  def self.up
    add_column :bookmarks, :category_id, :integer
  end

  def self.down
    remove_column :bookmarks, :category_id
  end
end
