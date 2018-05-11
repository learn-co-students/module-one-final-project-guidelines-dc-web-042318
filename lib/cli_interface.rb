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
    puts "x - Exit"
  end
  def main_user_selection(user_selection = " ")
      user_selection = gets.chomp
    while user_selection != 'x' do
      case user_selection
      when "1"
        puts "Enter a date in the MM-DD format:"
        date_value = gets.chomp
        user_selection = show_a_date(date_value)
        default_menu
        user_selection = gets.chomp.strip
      when "2"
        user_selection = search_for_a_person
        default_menu
        user_selection = gets.chomp.strip
      when "3"
        user_selection = search_for_an_event
        default_menu
        user_selection = gets.chomp.strip
      when "4"
        user_selection = show_event
        default_menu
        user_selection = gets.chomp.strip
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
    ""
  end

  def show_person(person)
    puts "Name: #{person.name}"
    if person.birth
      puts "Birth: #{person.birth.strftime('%Y-%m-%d')}"
    end
    if person.death
      puts "Death: #{person.death.strftime('%Y-%m-%d')}"
    end

    if !person.events
      puts "#{person.name} has no related events in our database."
    else
    puts "***************************"
    puts "Related events:"
      person.events.each do |event|
        puts "#{event.date.strftime('%Y-%m-%d')} - #{event.title}"
      end
    end
  end

  def show_event(event = nil)
    if !event
      event = Event.random_event
    end
    puts "*************************************"
    puts "Event Title: #{event.title}"
    puts "Event Date: #{event.date.strftime('%Y-%m-%d')}"
    if event.people
      puts "People Related: "
      event.people.each do |person|
        puts person.name
      end
    end
    ""
  end

  def show_a_date(date = nil, number_of_rows = 5)
    if !date
      date = time_rand.strftime('%m-%d')
    end
    people_born = Person.random_births(date, number_of_rows)
    people_died = Person.random_deaths(date, number_of_rows)
    events_of_the_day = Event.random_events_by_date(date, number_of_rows)
    puts "****************"
    puts "Born            "
    puts "****************"
    people_born.each {|n| puts "#{n.birth.strftime('%Y')}: #{n.name}, #{n.title}"}
    puts "****************"
    puts "Died            "
    puts "****************"
    people_died.each {|n| puts "#{n.death.strftime('%Y')}: #{n.name}, #{n.title}"}
    puts "****************"
    puts "Events          "
    puts "****************"
    events_of_the_day.each {|n| puts "#{n.date.strftime('%Y')} - #{n.title}"}

    ""
  end

  def time_rand from = 0.0, to = Time.now
    Time.at(from + rand * (to.to_f - from.to_f))
  end

  def search_for_an_event
    input = ''
    puts "Search for an event with a keyword"
    input = gets.strip
    search = Event.search_event(input)
    input = ''
    search.each_with_index { |n, i| 
      puts "#{i + 1}. #{n.title} DATE: #{n.date.strftime('%Y-%m-%d')}" 
      puts "------------------------------------"
    }
    puts "Select the event with index number:"
    input = gets.strip
    show_event(search[input.to_i-1])
    ""
  end
end













