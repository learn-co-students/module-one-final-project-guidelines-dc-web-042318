class Person < ActiveRecord::Base
	belongs_to :life_event, foreign_key: 'death_id'
	belongs_to :life_event, foreign_key: 'birth_id'
end