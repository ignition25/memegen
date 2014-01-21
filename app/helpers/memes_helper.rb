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
		# return ENV['S3_TEMPLATE_URL'] + template.path
	end

	def getMemeImagePath meme
		return ENV['S3_BUCKET_URL'] + meme.id.to_s + ".jpg"
	end

	def gaware_new_meme_path
		if params[:group_id]
			group = Group.find_by_key params[:group_id]
		elsif params[:id]
			group = Group.find_by_key params[:id]
		end

		if group
			return new_group_meme_path(group)
		else
			return new_meme_path
		end
	end

	def parse_context context
		if context =~ /((^(http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/
			return content_tag(:a, context, href: context)
		else
			return context
		end
	end

end
