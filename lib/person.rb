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

	def self.random_births_and_deaths(date, number_of_rows = 5)
		Person.search_for_birthday(date).order(date).sample(number_of_rows)
		Person.search_for_deathday(date).order(date).sample(number_of_rows) 
	end

	#  def average_age(date)
	#  end

end


