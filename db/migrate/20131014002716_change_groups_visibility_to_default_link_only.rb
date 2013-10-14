class ChangeGroupsVisibilityToDefaultLinkOnly < ActiveRecord::Migration
  def change
  	change_column :groups, :visibility, :string, :default => 'link_only'
  end
end
