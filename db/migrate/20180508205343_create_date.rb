class CreateDate < ActiveRecord::Migration[5.0]
  def change
  	create_table :historic_dates do |t|
  		t.integer :day
  		t.integer :month
  	end
  end
end
