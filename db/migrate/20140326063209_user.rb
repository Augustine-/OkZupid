class User < ActiveRecord::Migration
  def change
    add_column :messages, :secret, :boolean, default: false
  end
end
