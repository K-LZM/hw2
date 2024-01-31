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
Actor.destroy_all
Movie.destroy_all
Role.destroy_all
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

Batman_Begins = Movie.find_by({"title" => "Batman Begins"})
Christian_Bale = Actor.find_by({"name" => "Christian Bale"})

new_role = Role.new
new_role["movie_id"] = Batman_Begins["id"]
new_role["actor_id"] = Christian_Bale["id"]
new_role["character_name"] = "Bruce Wayne"
new_role.save

Michael_Caine = Actor.find_by({"name" => "Michael Caine"})
new_role = Role.new
new_role["movie_id"] = Batman_Begins["id"]
new_role["actor_id"] = Michael_Caine["id"]
new_role["character_name"] = "Alfred"
new_role.save


The_Dark_Knight = Movie.find_by({"title" => "The Dark Knight"})

new_role = Role.new
new_role["movie_id"] = Batman_Begins["id"]
new_role["actor_id"] = The_Dark_Knight["id"]
new_role["character_name"] = "Bruce Wayne"
new_role.save

The_Dark_Knight_Rises = Movie.find_by({"title" => "The Dark Knight Risest"})


# puts Actor.all.inspect


# new_actor = Actor.new
# new_actor["name"] = "Michael Caine"


puts Movie.all.inspect

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

movie_list = Movie.all
for movie in movie_list
   
    title = movie["title"]
    year_released = movie["year_released"]
    rated = movie["rated"]
    Studio.where({ "studio_id" => movie["studio_id"] })

    puts "#{title} #{year_released} #{rated} #{studio_name}"
  end

# for contact in apple_contact
#     puts "#{contact["first_name"]} #{contact["last_name"]}"
# end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

# for contact in apple_contact
#     puts "#{contact["first_name"]} #{contact["last_name"]}"
# end