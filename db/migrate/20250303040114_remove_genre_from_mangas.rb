class RemoveGenreFromMangas < ActiveRecord::Migration[8.0]
  def change
    remove_column :mangas, :genre, :string
  end
end
