class AddKeyToMemes < ActiveRecord::Migration
  def change
  	add_column :memes, :key, :string
  	add_index :memes, :key, :unique => true
  end
end
