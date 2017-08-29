require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)

  response = JSON.parse(RestClient.get("http://www.swapi.co/api/people/"))
  while (results)
    character_array = response["results"]
    found = character_array.find do |person|
      character == person["name"].downcase
    end #Returns array of URLs

    if found
      return found["films"]
    end
    response = response["next"] ? JSON.parse(RestClient.get(response["next"])) : nil
    # break if found || JSON.parse(all_characters)["next"].nil?
  end
  response
end

def parse_character_movies(film_array)
  neat_films = {}
  film_array.each do |url|
    movie = RestClient.get("#{url}")
    neat_films[url[-2]] = JSON.parse(movie)["title"]
  end # Returns hash of films with k/v pair of film# / title
  neat_films.map do |film_num, title|   # {film_num => title, film_num => title, ...}
    {film_num => title}
  end
end#Returns [{film_num => title},{film_num=>title}]

def print_movies(movie_array)
  movie_array.each do |movie|
    movie.each do |num, title|
      puts "Star Wars episode #{num}: #{title}"
    end
  end
end

def show_character_movies(character)
  film_array = get_character_movies_from_api(character) #Returns array of URLs

  if film_array
    neat_films = parse_character_movies(film_array) #Returns Array of hashes
    print_movies(neat_films)
  else
    puts "No character found."
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
