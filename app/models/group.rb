class Group < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :memes
	validates_uniqueness_of :name
	validates_presence_of :visibility, :name
end