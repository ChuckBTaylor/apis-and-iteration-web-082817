def welcome
  puts "Hello! Welcome to the incredible Star Wars Character movie searcher!"
end

def get_character_from_user
  puts "please enter a character"
  choice = gets.chomp
  choice.downcase
end
