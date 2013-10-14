class GroupsController < ApplicationController
	before_action :check_group_permissions, only: [:show]
	def create
		@group = Group.new(group_params)
		@group.key = UUID.new().generate
		current_user.groups << @group
	    respond_to do |format|
	      if @group.save
	        format.html { redirect_to group_path(@group), notice: 'Group was successfully created.' }
	        format.json { render json: { :status => 'success' } }
	      else
	      	error = ""
	      	@group.errors.each do |attr, msg|
	      		error << "#{attr} #{msg}. "
	      	end
	        format.html { redirect_to root_path, :flash => { error: 'There was an error creating your group, ' << error } } 
	        format.json { render json: @group.errors, status: :unprocessable_entity }
	      end
	  	end
	end

	def show
		@memes = @group.memes.order("created_at DESC")
		if params[:sort] and params[:sort] == "popular"
	      @memes = @memes.sort{|m1, m2| m2.popularity <=> m1.popularity }
	      @memes = Kaminari.paginate_array(@memes)
	    end
	    @memes = @memes.page(params[:page]).per($MEMES_PER_PAGE)
	end

	private
	    def group_params
	      params.require(:group).permit(:name, :visibility)
	    end

	    def check_group_permissions
			@group = Group.find_by_key(params[:id])
	    	if @group.visibility == "private" and !current_user or (current_user and !current_user.groups.include?(@group))
	    		not_found_error
	    	end
	    end
end