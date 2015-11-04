class RenameCharactersClassColumn < ActiveRecord::Migration
  def change
    rename_column :users, :class, :grad_class
  end
end
