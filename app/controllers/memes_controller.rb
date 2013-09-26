require 'RMagick'

class MemesController < ApplicationController
  before_action :set_meme, only: [:show, :edit, :update, :destroy]

  # GET /memes
  # GET /memes.json
  def index
    @memes = Meme.all
  end

  # GET /memes/1
  # GET /memes/1.json
  def show
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
    
    # Get params.
    template = params[:template]
    text_bottom = params[:content][:bottom]
    text_top = params[:content][:top]
    
    # Create Magick objects.
    final_image = Magick::ImageList.new(Rails.root.join(Memegen::Application::MAGICK_TEMPLATE_DIR, template))
    text_buffer = Magick::Draw.new

    if !text_top.empty?
      # Add top text.
      text_buffer.annotate(final_image, 0, 0, 0, 10, text_bottom.upcase) {
        self.font_family = 'Impact'
        self.gravity = Magick::SouthGravity
        self.pointsize = 48
        self.stroke = Memegen::Application::COLOR_BLACK
        self.fill = Memegen::Application::COLOR_WHITE
        self.font_weight = Magick::BoldWeight
      }
    end
    
    if !text_top.empty?
      # Add bottom text.
      text_buffer.annotate(final_image, 0, 0, 0, 10, text_top.upcase) {
        self.font_family = 'Impact'
        self.gravity = Magick::NorthGravity
        self.pointsize = 48
        self.stroke = Memegen::Application::COLOR_BLACK
        self.fill = Memegen::Application::COLOR_WHITE
        self.font_weight = Magick::BoldWeight
      }
    end

    respond_to do |format|
      if @meme.save
        # Create the meme file.
        final_image.write(Memegen::Application::MEME_OUTPUT_DIR + @meme.id.to_s + ".jpg")

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
      params.require(:meme).permit(:title, :context)
    end
end
