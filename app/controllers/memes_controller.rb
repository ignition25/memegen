require 'RMagick'

class MemesController < ApplicationController
  before_action :set_meme, only: [:destroy]

  MEMES_PER_PAGE = 20

  # GET /memes
  # GET /memes.json
  def index
    if params[:group]
      key = params[:group]
      group = Group.find_by_key(key)
      if group.visibility != "private" or (group.visibility == "private" and current_user and current_user.groups.include?(group))
        @memes = Group.find_by_key(key).memes.order("created_at DESC")
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    else
      @memes = Meme.where(:public => true).order("created_at DESC")
    end
    if params[:sort] and params[:sort] == "popular"
      @memes = @memes.sort{|m1, m2| m2.popularity <=> m1.popularity }
      @memes = Kaminari.paginate_array(@memes)
    end
    @memes = @memes.page(params[:page]).per(MEMES_PER_PAGE)
  end

  # GET /memes/1
  # GET /memes/1.json
  def show
    @meme = Meme.find_by_key(params[:id])
    if @meme.user_id
      user = User.find(@meme.user_id)
      if user.username
        @author = user.username
      end
    end
  end

  # GET /memes/new
  def new
    @meme = Meme.new
    @templates = Template.all
  end

  # POST /memes
  # POST /memes.json
  def create
    # TODO(juarez): Add security, sanitize input. Check if template is actually present.
    @meme = Meme.new(meme_params.merge({:key => UUID.new().generate}))
    meme_id = params[:meme][:id]

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

    if user_signed_in? and params[:groups]
      @meme.public = false
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
            flash[:error] = "We're very sorry, there was an error saving your meme. Please try again."
            @meme.destroy
            redirect_to :back
            return
          end
        else
          if user_signed_in?
            if params[:groups]
              params[:groups].each do |id|
                Group.find(id).memes << @meme
              end
            end
            # If the user is signed in then auto add an upvote from them.
            Vote.new(user: current_user, meme: @meme, value: :up).save
          end
        end
        format.html { redirect_to meme_path(@meme), notice: 'Meme was successfully created.' }
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
      format.html { redirect_to memes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meme
      @meme = Meme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meme_params
      params.require(:meme).permit(:context, :public)
    end

    def vote_params
      params.require(:vote).permit(:meme, :user_id, :value)
    end
end
