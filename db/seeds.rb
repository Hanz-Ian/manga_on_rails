# WEBD-3008 Full-Stack Web Development
# Name: Hanz Samonte
# Date: 03/02/2025
# Description: Rails Intro Project

require 'httparty'
require 'faker'

# Define a Jikan API as a class for use throughout the file
class JikanClient
  include HTTParty
  base_uri 'https://api.jikan.moe/v4'

  # Method for fetching the manga's full information based on the input
  def fetch_manga(manga_id)
    self.class.get("/manga/#{manga_id}/full")
  end

  # Method for fetching the character's information based on the input for its associated manga
  def fetch_manga_characters(manga_id)
    self.class.get("/manga/#{manga_id}/characters")
  end
end

# Create a Jikan client variable
client = JikanClient.new

# Clear existing data
MangaGenre.delete_all
Character.delete_all
MangaAuthor.delete_all
Author.delete_all
Genre.delete_all
Manga.delete_all

# List of inappropriate genres to filter out as a variable
inappropriate_genres = ["Ecchi", "Erotica"]

# Fetching and creating at least 190 data from Jikan API
(1..190).each do |manga_id|
  # Use fetch manga to grab manga id's information
  response = client.fetch_manga(manga_id)

  # If response is successful, parse the data and create objects
  if response.success?
    # Grab the manga data
    manga_data = response['data']

    # Check if the manga has any inappropriate genres, then skip it
    next if manga_data['genres'].any? { |genre| inappropriate_genres.include?(genre['name']) }

    # Create the Manga object
    manga = Manga.new(
      title: manga_data['title'],
      synopsis: manga_data['synopsis'].presence || Faker::Lorem.paragraph, # If null, use Faker
      chapters: manga_data['chapters'].presence || Faker::Number.between(from: 1, to: 100), # If null, use Faker
      release_date: manga_data['published']['from'].presence || Faker::Date.between(from: '2000-01-01', to: '2020-12-31'), # If Null, use Faker
      image_url: manga_data['images']['jpg']['image_url'],
      small_image_url: manga_data['images']['jpg']['small_image_url'],
      large_image_url: manga_data['images']['jpg']['large_image_url']
    )

    # If the object is saved successfully, create the other objects
    if manga.save
      # Fetch and create characters for each manga
      characters_response = client.fetch_manga_characters(manga_id)

      # If response is successfull, parse the character data and create objects
      if characters_response.success?
        # Grab the character data
        characters_data = characters_response['data']

        # For each character in the data, create an object
        characters_data.each do |character_data|
          Character.create(
            name: character_data['character']['name'],
            role: character_data['role'],
            manga: manga,
            image_url: character_data['character']['images']['jpg']['image_url']
          )
        end
      end

      # Fetch and create authors for each manga
      manga_data['authors'].each do |author_data|
        # If Author already exists, grab the name. Otherwise make the object
        author = Author.find_or_create_by(name: author_data['name'])
        # Add the Author to its associated manga, unless it's already there
        manga.authors << author unless manga.authors.include?(author)
      end

      # Fetch and create genres for each manga
      manga_data['genres'].each do |genre_data|
        # If Genre already exists, grab the name. Otherwise make the object
        genre = Genre.find_or_create_by(name: genre_data['name'])
        # Add the Genre to its associated manga, unless it's already there
        manga.genres << genre unless manga.genres.include?(genre)
      end
      
    else # Else, show error message when attempting to save manga object
      puts "Failed to save manga for ID #{manga_id}: #{manga.errors.full_messages}"
    end
  else # Else, show error message when attempting fetch manga data
    puts "Failed to fetch manga data for ID #{manga_id}: #{response.message}"
  end
end

# Generate 10 Faker made Mangas
10.times do
  # Create a Manga object using Faker
  manga = Manga.new(
    title: Faker::Book.title,
    synopsis: Faker::Lorem.paragraph,
    chapters: Faker::Number.between(from: 1, to: 100),
    release_date: Faker::Date.between(from: '2000-01-01', to: '2025-03-02'),
    image_url: Faker::LoremFlickr.image(size: "300x400", search_terms: ['manga']),
    small_image_url: Faker::LoremFlickr.image(size: "150x200", search_terms: ['manga']),
    large_image_url: Faker::LoremFlickr.image(size: "600x800", search_terms: ['manga'])
  )

  # If the object is saved successfully, create other objects using Faker
  if manga.save
    # Generate Faker characters for each Faker manga
    5.times do
      Character.create(
        name: Faker::Name.name,
        role: Faker::Job.title,
        manga: manga,
        image_url: Faker::LoremFlickr.image(size: "150x200", search_terms: ['character'])
      )
    end

    # Generate two Faker authors for each Faker manga
    2.times do
      # If Author already exists, grab the name. Otherwise make the object
      author = Author.find_or_create_by(name: Faker::Book.author)
      # Add the Author to its associated manga, unless it's already there
      manga.authors << author unless manga.authors.include?(author)
    end

    # Assign two random available genres to each Faker manga
    manga.genres << Genre.order('RANDOM()').limit(2)
  else # Else, show error message when attempting to save Faker manga object
    puts "Failed to save Faker manga: #{manga.errors.full_messages}"
  end
end

# Output
puts "Total Mangas created: #{Manga.count}"
puts "Total Characters created: #{Character.count}"
puts "Total Authors created: #{Author.count}"
puts "Total Genres created: #{Genre.count}"
puts "Total MangaGenres created: #{MangaGenre.count}"
puts "Total MangaAuthors created: #{MangaAuthor.count}"