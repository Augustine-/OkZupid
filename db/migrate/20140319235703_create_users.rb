class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :token
      t.string :species

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :token
    add_index :users, :species
  end
end
