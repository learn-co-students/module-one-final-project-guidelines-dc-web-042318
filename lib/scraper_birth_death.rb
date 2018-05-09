class LifeEvent
  attr_accessor :html, :event_type, :month, :day
  attr_writer :name, :title, :link, :year

  @@all = []

  def initialize(html, event_type, month, day)
    @html = html.children
    @event_type = event_type.downcase
    @month = month
    @day = day
    parse
    run
  end

  def parse
    parsed_text = self.html.text.gsub(/\(.*\)/, '').split(' – ').join(', ').split(', ')
    if parsed_text.length > 1
      return parsed_text
    else
      return ['9999','9999']
    end
  end

  def name
    if self.html.css('a').nil?
    return '9999'
  else
    return self.html.css('a').select { |l| l if (l.text[0] =~ /\d/).nil? }.first.text
  end
end

def title
  if self.name != parse[2..parse.length]
    return parse[2..parse.length].join(' ').sub(/\s+\Z/, '')
  else
    return ''
  end
end

def link
  href = self.html.select { |e| e.text.include?(self.name) }[0].attributes['href'].value
  "https://en.wikipedia.org#{href}"
end

def year
  parse[0].to_i
end

def date
  event_date = "#{self.month} #{self.day}, #{self.year}"
  Date.parse(event_date)
end

def run

  person = Person.find_or_create_by(link: link)
  person.name = name
  person.title = title
  if event_type.downcase == 'death'
    person.death = date
  elsif event_type.downcase == 'birth'
    person.birth = date
  end
  person.save

  @@all << { name: name, title: title, link: link, date: date, event_type: self.event_type }
  # puts '**********************************************'
  # puts "      #{self.event_type.upcase}"
  # puts "NAME: #{self.name}"
  # puts "TITLE: #{self.title}"
  # puts "DATE: #{self.month} #{self.day}, #{self.year}"
  # puts "LINK: #{self.link}"
end

def self.all
  @@all
end
end



