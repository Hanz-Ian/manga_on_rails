# Manga on Rails Data Project

## 1 - Gathering and Storing Data

### 1.1 - Describe Datasets
I'll be using the Jikan API to gather data about mangas. The Jikan API is an unofficial MyAnimeList API that provides access to detailed information about mangas, including their titles, synopses, genres, chapters, volumes, authors, publication dates, and characters.

#### Data Structure
The data from the Jikan API is structured in JSON format and includes the following key fields:
- `title`: The title of the manga.
- `synopsis`: A brief description of the manga.
- `genres`: An array of genres associated with the manga.
- `chapters`: The number of chapters in the manga.
- `volumes`: The number of volumes in the manga.
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
   - `volumes` (integer): The number of volumes in the manga.
   - `author` (string): A comma-separated list of authors.
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

5. **Volumes Table**
   - `number` (integer): The volume number.
   - `title` (string): The title of the volume.
   - `manga_id` (integer): Foreign key to the `mangas` table.

#### Integration
The data pulled from the Jikan API will be used to populate the `mangas`, `characters`, `genres`, `manga_genres`, and `volumes` tables in our database. Each manga entry will include information about its title, synopsis, genres, chapters, volumes, authors, and publication dates. The characters associated with each manga will be stored in the `characters` table, and the genres will be stored in the `genres` table. The `manga_genres` join table will establish the many-to-many relationship between mangas and genres. The `volumes` table will store information about the volumes of each manga.

This structure will allow us to create a comprehensive Manga catalogue where users can browse through mangas, view detailed manga pages, see associated characters, and explore genres.
