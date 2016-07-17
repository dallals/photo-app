class ImageAlbum < ActiveRecord::Base
  belongs_to :image
  belongs_to :album
  # acts_as_taggable



end
