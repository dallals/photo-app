class AddArrayToImages < ActiveRecord::Migration
  def change
  	change_column :images, :picture, :string, array: true, default: []
  end
end
