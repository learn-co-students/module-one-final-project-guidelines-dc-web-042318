class HistoricDate < ActiveRecord::Base
	has_many :holidays
	has_many :events
	has_many :life_events
	has_many :people, through: :life_events
end