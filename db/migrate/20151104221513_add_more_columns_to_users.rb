class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :class, :string
    add_column :users, :major, :string
  end
end
