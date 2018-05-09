class CreateEvents < ActiveRecord::Migration[5.0]
  def change
  	create_table :events do |t|
  		t.string :title
  		t.string :description
  		t.integer :historic_date_id
  		t.integer :year
  	end
  end
end
