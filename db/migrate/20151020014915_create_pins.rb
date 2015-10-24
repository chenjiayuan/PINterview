class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :title
      t.string :company
      t.string :date
      t.integer :difficulty
      t.string :type
      t.string :attire
      t.string :questions
      t.integer :like_count
      t.string :length
      t.string :description

      t.timestamps null: false
    end
  end
end
