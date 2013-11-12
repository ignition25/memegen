require 'RMagick'

class MemesController < ApplicationController
  before_action :check_meme_destroy_permission, only: [:destroy]
  before_action :check_meme_group_permissions, only: [:show]

  # GET /memes
  # GET /memes.json
  def index
    @memes = Meme.where(:group_id => nil).order("created_at DESC")
    @group = nil
    if params[:sort] and params[:sort] == "popular"
      @memes = @memes.sort{|m1, m2| m2.popularity <=> m1.popularity }
      @memes = Kaminari.paginate_array(@memes)
    end
    @memes = @memes.page(params[:page]).per($MEMES_PER_PAGE)
  end

  # GET /memes/1
  # GET /memes/1.json
  def show
    if @meme.user_id
      @author = User.find(@meme.user_id)
      if @author.username
        @author_name = @author.username
      end
    end
  end

  # GET /memes/new
  def new
    @meme = Meme.new
    @group = Group.find_by_key(params[:group_id])
    if current_user.try(:groups)
      @groups = current_user.groups
    elsif @group
      @groups = [@group]
    else
      @groups = []
    end
    @templates = Template.all
  end

  # POST /memes
  # POST /memes.json
  def create
    # TODO(juarez): Add security, sanitize input. Check if template is actually present.
    @meme = Meme.new(meme_params.merge({:key => UUID.new().generate, :user_id => current_user}))

    if user_signed_in?
      @meme.user_id = current_user.id
    end
    
    if !params[:images][:bg].empty?
      # Set result to background image.
      result = Magick::Image.read_inline(params[:images][:bg]).first
      result.format = "JPEG"
    end

    if !params[:images][:top].empty?
      image_top = Magick::Image.read_inline(params[:images][:top]).first
      result = result.composite!(image_top, Magick::CenterGravity, Magick::OverCompositeOp)
    end

    if !params[:images][:bottom].empty?
      image_bottom = Magick::Image.read_inline(params[:images][:bottom]).first
      result = result.composite!(image_bottom, Magick::CenterGravity, Magick::OverCompositeOp)
    end

    respond_to do |format|
      if @meme.save
        s3 = AWS::S3.new
        begin
          obj = s3.buckets[ENV['S3_BUCKET_NAME']].objects[@meme.id.to_s + ".jpg"]
          obj.write(result.to_blob, {:acl => :public_read, :cache_control => "max-age=14400"})
        rescue Exception => ex
          # Upload failed, try again.
          puts 'Error uploading meme to S3, retrying.'
          puts ex.message
          begin
            obj = s3.buckets[ENV['S3_BUCKET_NAME']].objects[@meme.id.to_s + ".jpg"]
            obj.write(result.to_blob, {:acl => :public_read, :cache_control => "max-age=14400"})
          rescue Exception => ex
            # Upload failed, alert the user and return to the previous page.
            puts 'Error uploading meme to S3 on 2nd and final attempt.'
            puts ex.message
            flash[:error] = "Oh noes! There was an error saving your meme, please try again."
            @meme.destroy
            redirect_to :back
            return
          end
        else
          # Upload completed.
          if user_signed_in?
            # If the user is signed in then auto add an upvote from them.
            Vote.new(user: current_user, meme: @meme, value: :up).save
          end
          if @meme.group
            redirect_path = group_meme_path(@meme.group, @meme)
          else
            redirect_path = meme_path(@meme)
          end
        end
        format.html { redirect_to redirect_path, notice: 'Meme was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meme }
      else
        format.html { render action: 'new' }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memes/1
  # DELETE /memes/1.json
  def destroy
    @meme.destroy
    respond_to do |format|
      format.html { redirect_to memes_url, notice: 'Meme was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meme
      @meme = Meme.find_by_key(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meme_params
      if params[:meme][:group_id] == "0" or params[:meme][:group_id] == 0
        # The meme is to be public.
        params[:meme].delete(:group_id)
      end
      params.require(:meme).permit(:context, :group_id)
    end

    def vote_params
      params.require(:vote).permit(:meme, :user_id, :value)
    end

    def check_meme_group_permissions
        @meme = Meme.find_by_key(params[:id])
        @group = @meme.group
        if !@group.nil? and (@group.visibility == "private") and (!current_user or (current_user and !current_user.groups.include?(@group)))
          not_found_error
        end
    end

    def check_meme_destroy_permission
      @meme = Meme.find_by_key(params[:id])
      if !current_user or (@meme.user_id != current_user.id and !current_user.admin)
        forbidden_access_error
      end
    end

end
