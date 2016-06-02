class CreateImageAlbums < ActiveRecord::Migration
  def change
    create_table :image_albums do |t|
      t.references :image, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
