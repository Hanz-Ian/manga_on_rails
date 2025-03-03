class Author < ApplicationRecord
  belongs_to :manga

  # Validations
  validates :name, presence: true, uniqueness: true
end
