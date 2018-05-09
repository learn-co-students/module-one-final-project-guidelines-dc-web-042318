class LifeEvent < ActiveRecord::Base
	belongs_to :historic_date
	belongs_to :death, class_name: 'Person'
	belongs_to :birth, class_name: 'Person'
end