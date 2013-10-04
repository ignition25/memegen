class AddIndexToGroups < ActiveRecord::Migration
  def change
  	add_index :groups, :key, :unique => true
  end
end
