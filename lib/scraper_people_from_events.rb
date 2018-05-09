class ScrapPeopleFromEvent
	attr_accessor :event_link, :people, :links

	def initialize(event_link)
		@event_link = event_link
		@links = links_from_page
	end

	def get_html
    	response = HTTParty.get(event_link)
    	Nokogiri::HTML(response.body)

	end

	def links_from_page
		response = get_html
		links = response.xpath('//div/a/@href')
	end

	# def people_in_this_event(people)
	# 	people.select do |person|
	# 		links.any?(person.link)
	# 	end
	# end

end