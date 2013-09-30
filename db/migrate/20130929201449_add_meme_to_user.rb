class AddMemeToUser < ActiveRecord::Migration
  def change
  	add_column :memes, :user_id, :integer
  end
end
