class CreateMangas < ActiveRecord::Migration[8.0]
  def change
    create_table :mangas do |t|
      t.string :title
      t.text :synopsis
      t.string :genre
      t.integer :chapters
      t.date :release_date

      t.timestamps
    end
  end
end
