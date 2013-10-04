class CreateGroupsMemes < ActiveRecord::Migration
  def change
    create_table :groups_memes do |t|
    	t.belongs_to :group
    	t.belongs_to :meme
    end
  end
end
