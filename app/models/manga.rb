class Manga < ApplicationRecord
  has_many :characters
  has_many :manga_genres
  has_many :genres, through: :manga_genres
  has_many :manga_authors
  has_many :authors, through: :manga_authors

  # Validations
  validates :title, :synopsis, :chapters, :release_date, presence: true
  validates :chapters, numericality: { only_integer: true }
  validates :title, uniqueness: true
end
