class Person < ActiveRecord::Base
	has_many :personevents 
	has_many :events, through: :personevents
end