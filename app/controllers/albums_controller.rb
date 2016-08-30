class AlbumsController < ApplicationController
 	before_action :set_album, only: [:edit, :update, :destroy, :show, :require_super_user]
 	before_action :require_same_user, only: [:edit, :update, :destroy, :show]
 	before_action :require_super_user, only: [:edit, :destroy, :update]
 	before_action :set_super_user, only: [:index, :show]
 	before_action :demo_account, only: [:destroy, :update, :create]
	
	def index
		if current_user.admin?
			@albums = Album.all.order(user_id: :asc)
		else
			@albums = Album.where(user_id: current_user.id)
		end	
		# @albums = Album.paginate(page: params[:page], per_page: 5).order(name: :asc)
		@images = Image.where(user_id: current_user)
	end

	def new
	  @album = Album.new
  	end


	def show
		# @image_albums = @album.images.paginate(page: params[:page], per_page: 5).order(updated_at: :desc)
    	@image_albums = @album.images.all.order(updated_at: :desc)
    	@id = User.find(@album.user_id) # in view page you can use User.find(@album.user_id).email 
	end

	def show_image
		# @album = Album.where(user_id: current_user)
		@image = Image.find(params[:id])
		# @album = @image.album(image_id: @image.id) 
		@album = Album.find_by(user_id: current_user) 
		@image_albums = @album.images.all.order(updated_at: :desc)
		@id = User.find(current_user)
		#need to make an albumimage controller to display single images with thumbnails from just the album
	end

	def create
		@album = Album.new(album_params)
		# @album.user_id = current_user.id 
		if @album.save
			flash[:success] = "You have created a new Album"
			redirect_to albums_path(current_user)
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

	def search
    @images = Image.search(params[:search_param])
    # puts @images
    if @images
      # @users = current_user.except_current_user(@users)
      render :show
      # render partial: "lookup"
    else
      render status: :not_found, nothing: true
    end
  end


  private

		def album_params
	  	params.require(:album).permit(:name).merge(user: current_user)
		end

  	def set_album
  		 @album = Album.find(params[:id])
    end

		def require_super_user
			unless current_user == User.find_by(email: 'sammydallal@gmail.com') || current_user.id == @album.user_id
			  flash[:info] = "You can only edit or delete your own Albums"
			  redirect_to albums_path
			end
		end

		def require_same_user
	    if current_user.id != @album.user_id and !current_user.admin?
	      flash[:danger] = "You can only view, edit or delete your own albums"
	      redirect_to albums_path
	    end
	  end

	  def set_super_user
	    @super_user = User.find_by(email: 'sammydallal@gmail.com')
	  end

end