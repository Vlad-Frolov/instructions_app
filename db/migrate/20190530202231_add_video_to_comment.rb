class AddVideoToComment < ActiveRecord::Migration[5.2]
  def change
  	add_column :comments, :video_url, :text, default: ''
  end
end
