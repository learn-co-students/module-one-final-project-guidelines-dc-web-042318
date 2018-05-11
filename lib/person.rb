class Person < ActiveRecord::Base
	has_many :personevents
	has_many :events, through: :personevents

	def self.search_individual(name)
		Person.all.where('name LIKE ?', "%#{name}%")
	end

	def self.retrieve_individual(index)
		Person.search_individual[index - 1]
	end

	def self.search_for_birthday(date)
    if date.split("-").length == 3
      Person.where(birth: date.to_date)
    elsif date.split("-").length == 2
      Person.where("cast(strftime('%m', birth) as int) = ? AND cast(strftime('%d', birth) as int) = ?",date.split("-")[0], date.split("-")[1])
    end
	end

	def self.search_for_deathday(date)
    if date.split("-").length == 3
      Person.where(death: date.to_date)
    elsif date.split("-").length == 2
      Person.where("cast(strftime('%m', death) as int) = ? AND cast(strftime('%d', death) as int) = ?",date.split("-")[0], date.split("-")[1])
    end
	end

	def self.random_person
		index = rand(0..Person.all.length - 1)
		Person.all[index]
	end

	def self.random_births(date, number_of_rows = 5)
		Person.search_for_birthday(date).order(date).sample(number_of_rows)
	end

		def self.random_deaths(date, number_of_rows = 5)
		Person.search_for_deathday(date).order(date).sample(number_of_rows) 
	end

def self.average_age(date)
		user_bday = date.split('-')
		birth_date = "#{user_bday[0]}-#{user_bday[1]}"
		births_and_deaths = Person.search_for_birthday(birth_date).where('birth AND death')
		average_seconds = births_and_deaths.map { |p| (p.death - p.birth) }.inject { |sum, n| (sum + n) } / births_and_deaths.length
		average_years = average_seconds.divmod(31557600).first
		average_days = (average_seconds.divmod(31557600).last) / 86400
		user_death = Date.strptime(date, "%m-%d-%Y").to_datetime + average_seconds.seconds
		puts "Among deceased historical figures born on #{birth_date}, the average age was #{average_years} years and #{average_days.to_i} days; #{average_years} years and #{average_days.to_i} days from #{date} is #{user_death.to_date.strftime('%m-%d-%Y')}..."
		''
	end

end


