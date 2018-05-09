class WikiParser
  attr_accessor :month, :day

  def initialize(month, day)
    @month = month
    @day = day
    run
  end

  def make_link
    "https://en.wikipedia.org/wiki/#{month}_#{day}"
  end

  def parsed_html_response
    response = HTTParty.get(make_link)
    Nokogiri::HTML(response.body)
  end

  def run
    make_link
    parsed_html_response
  end

  def scrape_life_events
    ['Birth', 'Death'].each do |event|
      title_h2 = parsed_html_response.at("h2:contains('#{event}s[edit]')")
      title_h2.at_xpath('following-sibling::ul').css('li').each do |person|
        LifeEvent.new(person, event, self.month, self.day)
      end
    end
  end

  def scrape_historic_events
    title_h2 = parsed_html_response.at("h2:contains('Events[edit]')")
    title_h2.at_xpath('following-sibling::ul').css('li').each do |event|
      HistoricEvent.new(event, self.month, self.day)
    end
  end
end

