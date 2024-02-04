# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!
Role.destroy_all
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!


new_studio = Studio.new
new_studio["name"] = "Warner Bros."
new_studio.save

Warner = Studio.find_by({"name" => "Warner Bros."})

new_movie = Movie.new
new_movie["title"] = "Batman Begins"
new_movie["year_released"] = 2005
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Warner["id"]
new_movie.save

new_movie = Movie.new
new_movie["title"] = "The Dark Knight"
new_movie["year_released"] = 2008
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Warner["id"]
new_movie.save

new_movie = Movie.new
new_movie["title"] = "The Dark Knight Rises"
new_movie["year_released"] = 2012
new_movie["rated"] = "PG-13"
new_movie["studio_id"] = Warner["id"]
new_movie.save

actor = [
"Christian Bale", 
"Michael Caine", 
"Liam Neeson", 
"Katie Holmes", 
"Gary Oldman", 
"Heath Ledger",
"Aaron Eckhart",
"Maggie Gyllenhaal", 
"Tom Hardy",
"Joseph Gordon-Levitt", 
"Anne Hathaway"]

for person in actor 
    new_actor = Actor.new
    new_actor["name"] = person
    new_actor.save
end

def add_role(movie_title, actor_name, character_name)
    movie = Movie.find_by({ "title" => movie_title })
    actor = Actor.find_by({ "name" => actor_name })
    new_role = Role.new
    new_role["movie_id"] = movie["id"]
    new_role["actor_id"] = actor["id"]
    new_role["character_name"] = character_name
    new_role.save
end

add_role("Batman Begins", "Christian Bale", "Bruce Wayne")
add_role("Batman Begins", "Michael Caine", "Alfred")
add_role("Batman Begins", "Liam Neeson", "Ra's Al Ghul")
add_role("Batman Begins", "Katie Holmes", "Rachel Dawes")
add_role("Batman Begins", "Gary Oldman", "Commissioner Gordon")

add_role("The Dark Knight", "Christian Bale", "Bruce Wayne")
add_role("The Dark Knight", "Heath Ledger", "Joker")
add_role("The Dark Knight", "Aaron Eckhart", "Harvey Dent")
add_role("The Dark Knight", "Michael Caine", "Alfred")
add_role("The Dark Knight", "Maggie Gyllenhaal", "Rachel Dawes")

add_role("The Dark Knight Rises", "Christian Bale", "Bruce Wayne")
add_role("The Dark Knight Rises", "Gary Oldman", "Commissioner Gordon")
add_role("The Dark Knight Rises", "Tom Hardy", "Bane")
add_role("The Dark Knight Rises", "Joseph Gordon-Levitt", "John Blake")
add_role("The Dark Knight Rises", "Anne Hathaway", "Selina Kyle")

# Batman_Begins = Movie.find_by({"title" => "Batman Begins"})
# Christian_Bale = Actor.find_by({"name" => "Christian Bale"})

# new_role = Role.new
# new_role["movie_id"] = Batman_Begins["id"]
# new_role["actor_id"] = Christian_Bale["id"]
# new_role["character_name"] = "Bruce Wayne"
# new_role.save

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!


max_title_length = Movie.maximum("LENGTH(title)") || 0
max_year_length = Movie.maximum("year_released").to_s.length
max_rated_length = Movie.maximum("LENGTH(rated)") || 0
max_studio_name_length = Studio.maximum("LENGTH(name)") || 0

format_string = "%-#{max_title_length + 2}s %-#{max_year_length + 2}s %-#{max_rated_length + 2}s %-#{max_studio_name_length + 2}s\n"

for movie in Movie.all
    title = movie["title"]
    year_released = movie["year_released"]
    rated = movie["rated"]
    studio = Studio.find_by({ "id" => movie["studio_id"] })
    printf(format_string, title, year_released, rated, studio["name"])
    # puts "#{title}   #{year_released}   #{rated}   #{studio["name"]}"
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

max_title_length = Movie.maximum("LENGTH(title)") || 0
max_actor_length = Actor.maximum("LENGTH(name)") || 0
max_character_length = Role.maximum("LENGTH(character_name)") || 0

format_string = "%-#{max_title_length + 2}s %-#{max_actor_length + 2}s %-#{max_character_length + 2}s\n"

for role in Role.all
    movie = Movie.find_by({ "id" => role["movie_id"]})
    actor = Actor.find_by({ "id" => role["actor_id"]})
    character = role["character_name"]
    printf(format_string, movie["title"], actor["name"], character)
    # puts "#{movie["title"]}   #{actor["name"]}   #{character}"
  end
