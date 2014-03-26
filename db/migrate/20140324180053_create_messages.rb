class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.text :title
      t.text :body

      t.timestamps
    end
    add_index :messages, :sender_id
    add_index :messages, :reciever_id
  end
end
