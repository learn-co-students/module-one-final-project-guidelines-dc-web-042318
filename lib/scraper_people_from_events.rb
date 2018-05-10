class ScrapPeopleFromEvent
	attr_accessor :event_link, :people, :links, :event_id

	def initialize(event_link)
		@event_link = event_link
		@links = links_from_page
		people_in_this_event
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
		people = links_from_page.map {|lnk| Person.find_by(link: lnk)}.compact
	end
end