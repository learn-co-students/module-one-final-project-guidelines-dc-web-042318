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
    self.html.text.gsub('-', '–').split(' – ')
  end

  def year
    parse[0].to_i
  end

  def title
    parse[1]
  end

  def links
    event_links = self.html.css('a').map { |el| "https://en.wikipedia.org#{el.attributes['href'].value}" }
    event_links[1..(event_links.length - 1)]
  end

  def date
    event_date = "#{self.month} #{self.day}, #{self.year}"
    Date.parse(event_date)
  end

  def run
    # event = Event.find_or_create_by(title: title)
    # event.date = date
    # event.link = links.join(',')
    # event.save

    @@all << { title: title, links: links, date: date }
    puts '**********************************************'
    puts "TITLE: #{self.title}"
    puts "DATE: #{self.month} #{self.day}, #{self.year}"
    puts links
  end

  def self.all
    @@all
  end
end
