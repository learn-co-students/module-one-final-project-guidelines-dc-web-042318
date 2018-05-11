class CLI_Functions

  def initialize
    initial_screen
    default_menu
    main_user_selection
  end

  def initial_screen
    puts "Welcome to the Date in the History"
    puts "**********************************"
    puts "For now, we have #{Event.all.length} events, #{Person.all.length} people and #{Personevent.all.length} relationships in our database."
  end
  def default_menu
    puts "**********************************"
    puts "Lets make your selection:"
    puts "1 - Search for a date"
    puts "2 - Search for a person"
    puts "3 - Search for an event"
    puts "4 - A random date in history"
    puts "5 - Enter a person to our database"
    puts "X - Exit"
  end
  def main_user_selection(user_selection = " ")
      user_selection = gets.chomp
    while user_selection != 'x' do
      case user_selection
      when "1"

      when "2"
        user_selection = search_for_a_person
        default_menu
        user_selection = gets.chomp
      when "3"

      when "4"

      when "5"

      when "x"
        break
      else
        puts "Please make a valid selection."
        default_menu
        user_selection = gets.chomp
      end

    end
    puts 'bye!'
  end

  # def name_search(name)
  #names.each_with_index{ |n, i| puts "#{i + 1}. #{n.name}" }
  # end

  def search_for_a_date
    puts "Please enter a date in the following formats:"
    puts "MM-DD or YYYY-MM-DD"
    user_selection = gets.chomp
    if user_selection.split("-").length == 3
      Event.where(date: user_selection.to_date)
    elsif user_selection.split("-").length == 2
      Event.where("cast(strftime('%m', date) as int) = ? AND cast(strftime('%d', date) as int) = ?",user_selection.split("-")[0], user_selection.split("-")[1])
    end
  end

  def search_for_a_person
    input = ''
    puts "Search for an individual"
    input = gets.strip
    search = Person.search_individual(input)
    input = ''
    search.each_with_index { |n, i| puts "#{i + 1}. #{n.name}     #{n.title}" }
    puts "Select the person with index number:"
    input = gets.strip
    show_person(search[input.to_i-1])
    " "
  end

  def show_person(person)
    puts "Name: #{person.name}"
    puts "Birth: #{person.birth.to_s}"
    puts "Death: #{person.death.to_s}"
    puts "***************************"
    puts "Related events:"
    if !person.events
      puts "#{person.name} has no related events in our database."
    else
      person.events.each do |event|
        puts event.title
      end
    end
  end
end













