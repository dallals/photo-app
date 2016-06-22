class AlbumsshowsController < ApplicationController
	before_action :set_album, only: [:show]
	before_action :set_image, only: [:show]
 	before_action :require_same_user, only: [:show]




 	def show
    @image = Image.find(params[:id])
 	  @image_albums = @album.images.all.order(updated_at: :desc)
    @id = User.find(current_user) # in view page you can use User.find(@album.user_id).email 
 	end


private

  	def set_album
  		 # @album = Album.where(ImageAlbum.find(@image :album_id))
  		 @album = Album.find(2)
    end

    def set_image
    	@images = Image.find(params[:id])
    end

  	def require_same_user
      if current_user.id != @images.user_id and !current_user.admin?
        flash[:danger] = "You can only view, edit or delete your own albums"
        redirect_to albums_path
      end
    end


end