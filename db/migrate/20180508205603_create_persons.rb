class CreatePersons < ActiveRecord::Migration[5.0]
  def change
  	create_table :people do |t|
  		t.string :name
  		t.datetime :death
  		t.datetime :birth
  		t.string :title
  		t.string :link
  	end
  end
end
