class CreateCharacters < ActiveRecord::Migration[8.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :role
      t.references :manga, null: false, foreign_key: true

      t.timestamps
    end
  end
end
