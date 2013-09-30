require 'RMagick'

class MemesController < ApplicationController
  before_action :set_meme, only: [:show, :edit, :update, :destroy]

  # GET /memes
  # GET /memes.json
  def index
    @memes = Meme.order("created_at DESC")
  end

  # GET /memes/1
  # GET /memes/1.json
  def show
    if @meme.user
      user = User.find(@meme.user)
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

  # GET /memes/1/edit
  def edit
  end

  # POST /memes
  # POST /memes.json
  def create
    # TODO(juarez): Add security, sanitize input. Check if template is actually present.
    @meme = Meme.new(meme_params)
    meme_id = params[:meme][:id]

    if user_signed_in?
      @meme.user = current_user
    end
    
    if !params[:images][:bg].empty?
      # Set result to background image.
      result = Magick::Image.read_inline(params[:images][:bg]).first
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
        result.write(Memegen::Application::MEME_OUTPUT_DIR + @meme.id.to_s + ".jpg")
        if user_signed_in?
          # If the user is signed in then auto add an upvote from them.
          Vote.new(user: current_user, meme: @meme, value: :up).save
        end

        format.html { redirect_to @meme, notice: 'Meme was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meme }
      else
        format.html { render action: 'new' }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memes/1
  # PATCH/PUT /memes/1.json
  def update
    respond_to do |format|
      if @meme.update(meme_params)
        format.html { redirect_to @meme, notice: 'Meme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
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
      params.require(:meme).permit(:context)
    end

    def vote_params
      params.require(:vote).permit(:meme, :user, :value)
    end
end
