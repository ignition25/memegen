class ChangeMemesToBelongToOneGroup < ActiveRecord::Migration
  def change
  	drop_table :groups_memes
  	add_column :memes, :group_id, :integer
  end
end
