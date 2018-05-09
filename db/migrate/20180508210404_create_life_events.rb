class CreateLifeEvents < ActiveRecord::Migration[5.0]
  def change
  	create_table :life_events do |t|
  		t.integer :historic_date_id
  		t.integer :person_id
  		t.integer :year
  	end
  end
end
