class Vote < ActiveRecord::Base
	validates :user, presence: true
	validates :meme, presence: true
	
	belongs_to :user
	belongs_to :meme
end
