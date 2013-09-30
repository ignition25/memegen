module MemesHelper

	def getVoteCount meme
		voteCount = meme.votes.where(value: :up).count - meme.votes.where(value: :down).count
		if voteCount < 0
			return 0
		end
		return voteCount
	end

	def getUserVoteValue meme
		if user_signed_in?
			user_vote = Vote.find_by_user_id_and_meme_id(current_user.id, meme.id)
			if user_vote
				puts user_vote.value
				return user_vote.value
			end
		end
	end

	def getTemplatePath template
		return Memegen::Application::TEMPLATE_DIR + template.path
	end

	def getMemePath meme
		return "/generated/" + meme.id.to_s + ".jpg"
	end
end
