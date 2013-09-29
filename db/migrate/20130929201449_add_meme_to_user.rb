class AddMemeToUser < ActiveRecord::Migration
  def change
  	add_column :memes, :user, :user
  end
end
