class Event < ActiveRecord::Base
	has_many :personevents
	has_many :people, through: :personevents
end