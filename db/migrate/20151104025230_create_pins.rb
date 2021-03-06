class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
  	  t.string :position
      t.string :company
      t.string :date
      t.string :difficulty
      t.string :type_interview
      t.string :attire
      t.string :questions
      t.integer :like_count, :default => 0
      t.string :length
      t.string :description 
      t.integer :user_id 
      t.string :position_type     
    end
  end
end
