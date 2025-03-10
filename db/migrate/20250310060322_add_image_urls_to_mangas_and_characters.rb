class AddImageUrlsToMangasAndCharacters < ActiveRecord::Migration[8.0]
  def change
    add_column :mangas, :image_url, :string
    add_column :mangas, :small_image_url, :string
    add_column :mangas, :large_image_url, :string
    add_column :characters, :image_url, :string
  end
end
