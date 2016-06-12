class AlbumsController < ApplicationController
	# before_action :require_same_user, only: [:edit, :update, :destroy, :index]
 #  	before_action :require_user
 	before_action :set_album, only: [:edit, :update, :destroy, :require_same_user]
 	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@albums = Album.all
		# @albums = Album.paginate(page: params[:page], per_page: 5).order(name: :asc)
		@images = Image.all
	end

	def new
	  @album = Album.new
  end

	def show
		@album = Album.find(params[:id])
		# @image_albums = @album.images.paginate(page: params[:page], per_page: 5).order(updated_at: :desc)
    	@image_albums = @album.images.all.order(updated_at: :desc)
    	@id = User.find(@album.user_id)
	end

	def create
		@album = Album.create album_params
		# @album.user_id = current_user.id 
		if @album.save
			flash[:success] = "You have created a new Album"
			redirect_to images_path(current_user)
		else
			flash[:danger] = "Album was not created please try again"
			redirect_to :back
		end
	end

	def destroy
		@album.destroy
		flash[:danger] = "Album was destroyed"
		redirect_to albums_path
	end

	def update
		if @album.update(album_params)
			flash[:success] = "Album was successfully updated"
			redirect_to album_path(@album)
		else
      flash[:danger] = "Album name must be at least 3 characters long or a maximum of 25 characters long"
			redirect_to :back
		end
	end


  private

  	def album_params
    	params.require(:album).permit(:name).merge(user: current_user)
  	end

  	def set_album
  		@album = Album.find(params[:id])
    end

  	def require_same_user
      if current_user.id != @album.user_id and !current_user.admin?
        flash[:danger] = "You can only edit or delete your own albums"
        redirect_to root_path
      end
    end

    def unique_album_name
      if @album.name  == Album.find_by(name: "@album.name")
      end
    end


end