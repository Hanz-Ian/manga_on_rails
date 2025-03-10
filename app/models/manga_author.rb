class MangaAuthor < ApplicationRecord
  # 1.5 - many-to-many association
  belongs_to :manga
  belongs_to :author
end
