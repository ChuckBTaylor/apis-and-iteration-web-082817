require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_array = JSON.parse(all_characters)["results"] #returns array of characters
  character_array.find do |person|
    character == person["name"]
  end["films"]




  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(film_array)
  neat_films = {}
  film_array.each do |url|
    movie = RestClient.get("#{url}")
    neat_films[url[-2] = JSON.parse(movie)["title"])
  end
  neat_films
  binding.pry
end

def print_movies(movie_array)
  counter = 1
  movie_array.each do |movie|
    puts "#{counter} #{movie}"
    counter += 1
  end
end

def show_character_movies(character)
  film_array = get_character_movies_from_api(character)
  neat_films = parse_character_movies(film_array)
  print_movies(neat_films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
