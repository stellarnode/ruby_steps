movies = {
    avatar: 5,
    matrix: 5
}

puts "What would you like to do?"
puts "  - print \"add\" to add a movie to your library"
puts "  - print \"update\" to update a movie rating in your library"
puts "  - print \"display\" to display movies in your library and their ratings"
puts "  - print \"delete\" to delete a movie from your library"
choice = gets.chomp

case choice
when "add"
    puts "What movie would you like to add?"
    title = gets.chomp.downcase
    
    if movies[title.to_sym].nil?
        puts "What is this movie rating?"
        rating = gets.chomp.to_i
        movies[title.to_sym] = rating
        puts "The movie titled \"#{title.capitalize}\" added to the library with rating #{rating.to_s}."
    else
        puts "The movie titled \"#{title.capitalize}\" is already in your library with rating #{movies[title.to_sym].to_s}."
    end

when "update"
    puts "What movie would you like to update?"
    title = gets.chomp.downcase
    
    if movies[title.to_sym].nil?
        puts "There is no movie titled \"#{title.capitalize}\" in your library."
    else
        puts "What rating would you like to assign to movie \"#{title.capitalize}\"?"
        rating = gets.chomp.to_i
        movies[title.to_sym] = rating
        puts "The movie titled \"#{title.capitalize}\" assigned new rating #{rating.to_s}."
    end

when "display"
    movies.each do |k, v|
        puts "#{k}: #{v}"
    end

when "delete"
    puts "What movie would you like to delete?"
    title = gets.chomp.downcase
    
    if movies[title.to_sym].nil?
        puts "There is no movie titled \"#{title.capitalize}\" in your library."
    else
        movies.delete(title.to_sym)
        puts "The movie titled \"#{title.capitalize}\" deleted from your library."
    end

else
    puts "I do not understand your command. Please use \"add\", \"update\", \"display\" or \"delete\"."

end