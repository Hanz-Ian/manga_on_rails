class RemoveMangaIdFromAuthors < ActiveRecord::Migration[8.0]
  def change
    remove_column :authors, :manga_id, :integer
  end
end
