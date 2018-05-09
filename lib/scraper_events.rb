class HistoricEvent
  attr_accessor :html, :month, :day
  attr_writer :title, :links, :year

  @@all = []

  def initialize(html, month, day)
    @html = html.children
    @month = month
    @day = day
    parse
    run
  end

  def parse
    parsed_text = self.html.text.gsub('-', '–').split(' – ')
    if parsed_text.length > 1
      return parsed_text
    else
      return ['9999','9999']
    end
  end

  def year
    if parse[0].nil?
      return 9999
    else
      return parse[0].to_i
    end
  end

  def title
    if parse[1].nil?
      return ''
    else
      return parse[1]
    end
  end

  def links
    event_links = self.html.css('a').map { |el| "https://en.wikipedia.org#{el.attributes['href'].value}" }
    if event_links.length > 0
      return event_links[1..(event_links.length - 1)]
    else
      return ['']
    end
  end

  def date
    event_date = "#{self.month} #{self.day}, #{self.year}"
    Date.parse(event_date)
  end

  def run
    event = Event.find_or_create_by(title: title)
    event.date = date
    event.link = links.join(',')
    event.save

    @@all << { title: title, links: links, date: date }
    # puts '**********************************************'
    # puts "TITLE: #{self.title}"
    # puts "DATE: #{self.month} #{self.day}, #{self.year}"
    # puts links
  end

  def self.all
    @@all
  end
end
