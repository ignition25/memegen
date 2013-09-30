class Meme < ActiveRecord::Base
	has_many :votes

	def popularity
		num_up_votes = self.votes.where(value: :up).count
		popularity = (num_up_votes)/(((Time.now - self.created_at + 2)/3600)**(1.5))
	end
end
