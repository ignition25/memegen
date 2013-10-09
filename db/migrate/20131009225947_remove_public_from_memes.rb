class RemovePublicFromMemes < ActiveRecord::Migration
  def change
  	remove_column :memes, :public
  end
end
