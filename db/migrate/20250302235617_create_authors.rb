class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.references :manga, null: false, foreign_key: true

      t.timestamps
    end
  end
end
