class CreateUsers < ActiveRecord::Migration
  def change
   create_table :users do |t|
      t.string :name, :unique => true, :null => false
      t.string :ign, :unique => true, :null => false
      t.integer :rank, :default => 10, :null => false
      t.boolean :banned, :default => false
      t.string :email, :unique => true, :null => false
      t.text :about
      t.string :password_digest, :null => false
      t.string :last_ip

      t.timestamps
    end
  end
end