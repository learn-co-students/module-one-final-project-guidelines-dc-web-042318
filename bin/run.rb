require_relative '../config/environment'

def test_search
  puts "Search for an individual"
  input = gets.chomp
  search = Person.search_individual(input)
  search.each_with_index { |n, i| puts "#{i + 1}. #{n.name}     #{n.title}" }
end

CLI_Functions.new

binding.pry

puts "done"

