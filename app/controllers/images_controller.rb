class ImagesController < ApplicationController
  # before_action :require_super_user, only: [:edit, :destroy]
  before_action :set_image, only: [:show, :edit, :update, :destroy, :require_super_user]
  before_action :require_super_user, only: [:edit, :destroy, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy, :show]
  before_action :require_user

  # GET /images
  # GET /images.json
  def index
    @user = User.all
    @id = User.find(current_user)
    if current_user.admin?
      @images = Image.all.order(:user_id)
    else
      @images = Image.where(user_id: current_user).order(updated_at: :desc)
    # @images = Image.where(user_id: current_user).paginate(page: params[:page], per_page: 2).order(updated_at: :desc)
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @id = User.find(@image.user_id)
    if current_user.admin?
      @images = Image.where(user_id: @id)
    else
      @images = Image.where(user_id: current_user)
    end
  end

  # GET /images/new
  def new
    @id = User.find(current_user)
    @image = Image.new
    @albums = Album.all
  end

  # GET /images/1/edit
  def edit
    @id = User.find(@image.user_id)
    # @albums = current_user.albums  
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    @image.user = current_user
    # add_more_images(image_params[:id])
    # flash[:error] = "Failed uploading images" unless @image.save
    

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
        flash[:danger] = "You have exceeded the maximum number of photos(100) you can upload."
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
        flash[:danger] = "Name must be 3 characters long or a maximum of 30 characters long, or you have reached the maximum number of images allowed delete one image to update"
        format.html { redirect_to :back }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    @images = Image.search(params[:search_param])
    # puts @images
    if @images
      # @users = current_user.except_current_user(@users)
      render partial: "lookup"
    else
      render status: :not_found, nothing: true
    end
  end

  def searchuser
    @users = User.search(params[:search_param])
    # puts @images
    if @users
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

    def require_super_user
      unless current_user == User.find_by(email: 'sammydallal@gmail.com') || current_user.id == @image.user_id
        flash[:info] = "You can only edit or delete your own photos"
        redirect_to :back
      end
    end

    # def add_more_images(new_images)
    #   images = @image.picture # copy the old images 
    #   images += new_images # concat old images with new ones
    #   @image.picture = images # assign back
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :caption, :picture, :user_id, :credit, { picture: []}, album_ids: [])
    end

    def require_same_user
      if current_user.id != @image.user_id and !current_user.admin?
        flash[:danger] = "You can only view, edit or delete your own photos"
        redirect_to images_path
      end
    end
end
