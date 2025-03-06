# Manga on Rails Data Project

## 1 - Gathering and Storing Data

### 1.1 - Describe Datasets

I'll be using the Jikan API to gather data about mangas. The Jikan API is an unofficial MyAnimeList API that provides access to detailed information about mangas, including their titles, synopses, genres, chapters, authors, publication dates, and characters.

#### Data Structure

The data from the Jikan API is structured in JSON format and includes the following key fields:
- `title`: The title of the manga.
- `synopsis`: A brief description of the manga.
- `genres`: An array of genres associated with the manga.
- `chapters`: The number of chapters in the manga.
- `authors`: An array of authors who worked on the manga.
- `published`: The publication dates of the manga.
- `characters`: An array of characters associated with the manga.

#### Required Database Tables and Columns

To store the manga data, we will create the following database tables:

1. **Mangas Table**
   - `title` (string): The title of the manga.
   - `synopsis` (text): A brief description of the manga.
   - `genre` (string): A comma-separated list of genres.
   - `chapters` (integer): The number of chapters in the manga.
   - `release_date` (date): The publication start date of the manga.

2. **Characters Table**
   - `name` (string): The name of the character.
   - `description` (text): A brief description of the character.
   - `manga_id` (integer): Foreign key to the `mangas` table.

3. **Genres Table**
   - `name` (string): The name of the genre.

4. **MangaGenres Table** (Join table for many-to-many relationship between mangas and genres)
   - `manga_id` (integer): Foreign key to the `mangas` table.
   - `genre_id` (integer): Foreign key to the `genres` table.

5. **Authors Table**
   - `name` (string): The name of the author.
   - `manga_id` (integer): Foreign key to the `mangas` table.

6. **MangaAuthors Table** (Join table for many-to-many relationship between mangas and authors)
   - `manga_id` (integer): Foreign key to the `mangas` table.
   - `author_id` (integer): Foreign key to the `authors` table.

#### Integration

The data pulled from the Jikan API will be used to populate the `mangas`, `characters`, `genres`, `manga_genres`, `authors`, and `manga_authors` tables in the database. Each manga entry will include information about its title, synopsis, genres, chapters, authors, and publication dates. The characters associated with each manga will be stored in the `characters` table, and the genres will be stored in the `genres` table. The `manga_genres` join table will establish the many-to-many relationship between mangas and genres. The `manga_authors` join table will establish the many-to-many relationship between mangas and authors.

### 1.2 - Database ERD

## Entity-Relationship Diagram

![ERD](app/assets/images/erd.png)

### 1.7 - Data Sources

The `seeds.rb` script is used to pull in data from 2 sources into the database. The primary data source is the Jikan API, which provides detailed information about mangas. Additionally, the Faker gem will also be used to generate data for missing fields and for testing.

## Models

### Manga Model
- `id` (auto increment PK)
- `title` (string)
- `synopsis` (text)
- `chapters` (integer)
- `release_date` (date)
- Will also be part of the many-to-many relationship with Genre

### Character Model
- `id` (auto increment PK)
- `name` (string)
- `role` (string)
- `manga_id` (integer, FK)

### Genre Model
- `id` (auto increment PK)
- `name` (string)
- Will also be part of the many-to-many relationship with Manga

### MangaGenre Model
- `manga_id` (integer, FK)
- `genre_id` (integer, FK)

### Author Model
- `id` (auto increment PK)
- `name` (string)
- `manga_id` (integer, FK)

### MangaAuthor Model
- `manga_id` (integer, FK)
- `author_id` (integer, FK)

## Our many-to-many relationship

We will end up with a table like this for our Manga to Genre relationship:

### MangaGenres Table
- `manga_id` (integer, FK)
- `genre_id` (integer, FK)

### MangaAuthors Table
- `manga_id` (integer, FK)
- `author_id` (integer, FK)
