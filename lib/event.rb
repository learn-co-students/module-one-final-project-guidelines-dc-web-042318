class Event < ActiveRecord::Base
	has_many :personevents
	has_many :people, through: :personevents

	def find_and_assign_people
		event_links = self.link.split(",")
		event_links.each do |link|
			event_people = ScrapPeopleFromEvent.new(link)
			event_people.each do |event_person|
				self.people << Person.find_by(id: event_person)
			end
		end
	end
end