class Manga < ApplicationRecord
  has_many :characters
  has_many :authors
  has_many :manga_genres
  has_many :genres, through: :manga_genres

  # Validations
  validates :title, :synopsis, :chapters, :release_date, presence: true
  validates :chapters, numericality: { only_integer: true }
  validates :title, uniqueness: true
end
