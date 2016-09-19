# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # include CarrierWave::MiniMagick
  include CarrierWave::RMagick
  process resize_to_limit: [1000, 1000] unless %w(pdf doc)

  

  # process :store_dimensions

  # If you like, you can call this inside a version like this
  # instead of at the top level.
  # That will store the dimensions for this version.
 
  # version :show do
  #   process :resize_to_limit => [1000, 1000]
  #   process :store_dimensions
  # end


  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # include CarrierWave::MimeTypes
  
  # def convert_to_image(height, width)
  #   image = ::Magick::Image.read(current_path + "[0]")[0]
  #   image.resize_to_fit(height,width).write(current_path)
  # end

  # version :preview do
  #   process :covert_to_image(100, 100)
  #   process :convert => :jpg

  #   def full_filename (for_file = model.source.file)
  #     super.chomp(File.extname(super)) + '.jpg'
  #   end
  # end





  # Choose what kind of storage to use for this uploader:
  
  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end

  if Rails.env.development?
    storage :fog
  else
    storage :file
  end
  

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png pdf)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #  "something.jpg" if original_filename
  # end
  # private

  # def store_dimensions
  #   if file && model
  #     model.width, model.height = `identify -format "%wx%h" #{file.path}`.split(/x/)
  #   end
  # end


end
