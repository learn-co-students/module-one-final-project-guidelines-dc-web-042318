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
		births_and_deaths = Person.search_for_birthday(date).where('birth AND death')
		average_seconds = births_and_deaths.map { |p| (p.death - p.birth) }.inject { |sum, n| (sum + n) } / births_and_deaths.length
		years = average_seconds.divmod(31557600).first
		days = (average_seconds.divmod(31557600).last) / 86400
		puts "On #{date}, the average age of a deceased historical figure is #{years} years and #{days.to_i} days."
		years
	end

end


