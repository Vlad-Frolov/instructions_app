class AddVideoFieldToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :video_url, :text, default: ''
  end
end
