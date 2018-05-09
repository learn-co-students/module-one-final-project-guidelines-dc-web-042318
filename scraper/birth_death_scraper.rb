require 'nokogiri'
require 'pry'
require 'httparty'

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
    self.html.text.gsub(/\(.*\)/, '').split(' – ').join(', ').split(', ')
  end

  def name
    self.html.css('a').select { |l| l if (l.text[0] =~ /\d/).nil? }.first.text
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
    #check BC
    parse[0].to_i
  end

  def run

    name
    title
    link
    year
    @@all << self
    puts '**********************************************'
    puts "      #{self.event_type.upcase}"
    puts "NAME: #{self.name}"
    puts "TITLE: #{self.title}"
    puts "DATE: #{self.month} #{self.day}, #{self.year}"
    puts "LINK: #{self.link}"
  end

  def self.all
    @@all
  end
end

def scrape_life_event(month, day)
  link = "https://en.wikipedia.org/wiki/#{month}_#{day}"
  response = HTTParty.get(link)
  doc = Nokogiri::HTML(response.body)
  ['Birth', 'Death'].each do |event|
    title_h2 = doc.at("h2:contains('#{event}s[edit]')")
    title_h2.at_xpath('following-sibling::ul').css('li').each do |person|
      LifeEvent.new(person, event, month, day)
      sleep(0.1)
    end
  end
end

scrape_life_event('July', 12)
