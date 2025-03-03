class Character < ApplicationRecord
  belongs_to :manga

  # Validations
  validates :name, :role, presence: true
end
