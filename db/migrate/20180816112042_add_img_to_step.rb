class AddImgToStep < ActiveRecord::Migration[5.2]
  def change
    add_column :steps, :img_url, :text, default: ''
  end
end
