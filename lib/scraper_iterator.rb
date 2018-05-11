def run_dates
  dates = ('January 1, 2012'.to_date..'December 31, 2012'.to_date).map{ |t| t.strftime("%B %d").split(' ') }

  dates.each do |date|
    database_download = WikiParser.new(date[0], date[1].to_i)
    database_download.scrape_life_events
    database_download.scrape_historic_events
    puts date
  end
end

def run_connector
  Event.all.each { |e| e.find_and_assign_people }
end