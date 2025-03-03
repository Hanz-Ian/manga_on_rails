class Author < ApplicationRecord
  has_many :manga_authors
  has_many :mangas, through: :manga_authors

  # Validations
  validates :name, presence: true, uniqueness: true
end
