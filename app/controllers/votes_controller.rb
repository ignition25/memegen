class VotesController < ApplicationController

  # POST /votes/1.json
  def vote
    if !(vote = Vote.find_by_user_id_and_meme_id(vote_params[:user_id], vote_params[:meme_id])).nil?
    	vote.update(vote_params)
   	else 
   		vote = Vote.new(vote_params)
   		vote.save
   	end
    
    meme = Meme.find(vote_params[:meme_id])
    vote_count = meme.votes.where(value: :up).count - meme.votes.where(value: :down).count
    if vote_count < 0
    	vote_count = 0
    end

    respond_to do |format|
        format.json { render json: { :vote_count => vote_count } }
    end
  end

   private

    def vote_params
      params.require(:vote).permit(:meme_id, :user_id, :value)
    end
end