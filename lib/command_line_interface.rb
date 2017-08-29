def welcome
  puts "Hello! Welcome to the incredible Star Wars Character movie searcher!"
end

def get_character_from_user
  puts "please enter a character"
  choice = gets.chomp
  capitalize_name(choice)
end

def capitalize_name(name)
  if name.index(/[0123456789-]/)
    return name.upcase
  else
    name.split.map do |word|
      word.capitalize
    end.join(" ")
  end
end
