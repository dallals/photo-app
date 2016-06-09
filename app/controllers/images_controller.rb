class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_user

  # GET /images
  # GET /images.json
  def index
    @images = Image.all.order(updated_at: :desc)
    # @images = Image.paginate(page: params[:page], per_page: 10).order(updated_at: :desc)
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
    @albums = Album.all
  end

  # GET /images/1/edit
  def edit
    @albums = current_user.albums

    
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.user = current_user
    # @album = Album.all
    # @image.album_id = @album.id

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        flash[:danger] = "Name must be at least 3 characters long or a maximum of 30 characters long"
        format.html { redirect_to :back }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    @images = Image.search(params[:search_param])
    puts @images
    if @images
      # @users = current_user.except_current_user(@users)
      render partial: "lookup"
    else
      render status: :not_found, nothing: true
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :caption, :picture, :user_id, :credit, { picture: []}, album_ids: [])
    end

    def require_same_user
      if current_user.id != @image.user_id and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own photos"
        redirect_to root_path
      end
  end
end
