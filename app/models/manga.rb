class Manga < ApplicationRecord
  has_many :characters
  has_many :authors
  has_many :manga_genres
  has_many :genres, through: :manga_genres
end
