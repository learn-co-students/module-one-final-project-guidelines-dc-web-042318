class ScrapPeopleFromEvent
	attr_accessor :event_link, :people, :links, :event_id, :event

	def initialize(event)
		@event = event
		@event_link = event.link
		@links = links_from_page
		assign_people
	end

	def get_html
    	response = HTTParty.get(event_link)
    	Nokogiri::HTML(response.body)
	end

	def links_from_page
		response = get_html
		links = response.xpath('//a/@href')
		links = links.select do |lnk|
			!(lnk.value =~ /Main_Page|File:|https:|Help:Category|mw-head|p-search|cite_note/)
		end
		links.map {|lnk| "https://en.wikipedia.org#{lnk.value}"}.uniq
	end

	def people_in_this_event
		links_from_page.map {|lnk| Person.find_by(link: lnk)}.compact
	end

	def assign_people
		people_in_this_event.each { |p| p.events << self.event }
	end
end