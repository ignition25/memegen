class GroupsController < ApplicationController
	def create
		@group = Group.new(group_params)
		@group.key = UUID.new().generate
		current_user.groups << @group
	    respond_to do |format|
	      if @group.save
	        format.html { redirect_to root_path, notice: 'Group was successfully created.' }
	        format.json { render json: { :status => 'success' } }
	      else
	        format.html { redirect_to root_path, notice: 'There was an error creating your group, please try again.' }
	        format.json { render json: @group.errors, status: :unprocessable_entity }
	      end
	  	end
	end

	private
	    def group_params
	      params.require(:group).permit(:name, :visibility)
	    end
end