class CLI_Functions

  def initialize

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
      user_selection = gets.chomp

      case user_selection
      when "1"

      when "2"

      when "3"

      when "4"

      when "5"

      when "x"
          break
      else
          puts "Please make a valid selection"
          default_menu
      end
  end

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
end