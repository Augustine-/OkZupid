class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :prompt
      t.string :content
      t.integer :profile_id
      
      
      t.timestamps
    end
    add_index :posts, :profile_id
  end
end
