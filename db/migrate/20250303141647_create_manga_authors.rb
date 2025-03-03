class CreateMangaAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :manga_authors do |t|
      t.references :manga, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
