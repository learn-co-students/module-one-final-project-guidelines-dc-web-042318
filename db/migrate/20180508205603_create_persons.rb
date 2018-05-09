class CreatePersons < ActiveRecord::Migration[5.0]
  def change
  	create_table :people do |t|
  		t.string :name
  		t.integer :death_id
  		t.integer :birth_id
  		t.string :short_bio
  	end
  end
end
