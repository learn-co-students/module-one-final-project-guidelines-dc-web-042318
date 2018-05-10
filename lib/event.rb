class Event < ActiveRecord::Base
	has_many :personevents
	has_many :people, through: :personevents

	def self.search_event(title)
		Event.all.where('title LIKE ?', "%#{title}%")
	end

	def self.search_for_a_date(date)
    if date.split("-").length == 3
      Event.where(date: date.to_date)
    elsif date.split("-").length == 2
      Event.where("cast(strftime('%m', date) as int) = ? AND cast(strftime('%d', date) as int) = ?",date.split("-")[0], date.split("-")[1])
    end
	end

	def self.random_event
		index = rand(0..Event.all.length - 1)
		Event.all[index]
	end

	def self.random_events_by_date(date)
		Event.search_for_a_date(date).sample(5).each { |e| puts "#{e.date.strftime('%Y')}: #{e.title} (#{e.link})"}
	end

	def find_and_assign_people
		ScrapPeopleFromEvent.new(self) rescue ArgumentError
		''
	end
end