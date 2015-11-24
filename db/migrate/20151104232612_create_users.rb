class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :major
      t.string :grad_class
      t.attachment :avatar
    end
  end
end
