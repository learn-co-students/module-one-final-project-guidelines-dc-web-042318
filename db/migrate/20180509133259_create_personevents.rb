class CreatePersonevents < ActiveRecord::Migration[5.2]
  def change
  	create_table :personevents do |t|
  		t.integer :person_id
  		t.integer :event_id
  	end
  end
end
