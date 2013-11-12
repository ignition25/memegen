class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@favorites = []
		@user.votes.order("updated_at DESC").each do |vote|
			if vote.value == 'up'
				if !(meme = Meme.find_all_by_id(vote.meme_id).first).nil? && meme.user_id != @user.id && meme.group_id == nil
					@favorites << meme
				end
			end
		end

		@memes = @user.memes.where(:group_id => nil).order("created_at DESC")
	end
end