require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  counter =   1
  found = nil
  loop do
    all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{counter}")
    character_array = JSON.parse(all_characters)["results"] #returns array of characters
    found = character_array.find do |person|
      character == person["name"]
    end #Returns array of URLs
    counter += 1
    break if found != nil
  end
  found != nil ? return found["films"] : return nil
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
  film_array neat_films = parse_character_movies(film_array) #Returns Array of hashes
                                                  #e.g.[{1=>"A New Hope"},2=>"Empire Strikes Back"}]
  print_movies(neat_films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
