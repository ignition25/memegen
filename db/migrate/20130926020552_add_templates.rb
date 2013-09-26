class AddTemplates < ActiveRecord::Migration
  def change
  	create_table :templates do |t|
      t.string :title
      t.string :path

      t.timestamps
    end
  end
end
