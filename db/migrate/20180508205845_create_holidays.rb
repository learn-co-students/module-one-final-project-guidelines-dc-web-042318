class CreateHolidays < ActiveRecord::Migration[5.0]
  def change
  	create_table :holidays do |t|
  		t.integer :year
  		t.string :name
  		t.integer :historic_date_id
  		t.string :description
  		t.string :occurence
  	end
  end
end
