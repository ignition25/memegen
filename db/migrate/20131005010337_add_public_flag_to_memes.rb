class AddPublicFlagToMemes < ActiveRecord::Migration
  def change
    add_column :memes, :public, :boolean, :default => true
  end
end
