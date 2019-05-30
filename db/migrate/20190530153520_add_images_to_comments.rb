class AddImagesToComments < ActiveRecord::Migration[5.2]
  def change
  	add_column :comments, :img_url, :text, default: ''
  end
end
