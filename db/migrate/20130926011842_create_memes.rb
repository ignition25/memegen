class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :context

      t.timestamps
    end
  end
end
