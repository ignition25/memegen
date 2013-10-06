module MemesHelper

	def getVoteCount meme
		voteCount = meme.votes.where(value: :up).count - meme.votes.where(value: :down).count
		if voteCount < 0
			return 0
		end
		return voteCount
	end

	def getUserVote meme
		if user_signed_in?
			user_vote = Vote.find_by_user_id_and_meme_id(current_user.id, meme.id)
			return user_vote
		end
	end

	def getTemplatePath template
		return 'templates/' + template.path
	end

	def getMemePath meme
		return ENV['S3_BUCKET_URL'] + meme.id.to_s + ".jpg"
	end

	def getUserGroups
		if user_signed_in?
			return current_user.groups
		else
			return []
		end
	end

	def meme_path(meme, options={})
	  meme_url(meme, options.merge(:only_path => true))
	end

	def meme_url(meme, options={})
	  url_for(options.merge(:controller => 'memes', :action => 'show',
	                        :id => meme.key))
	end
end
