class AddDefaultImage < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :image, from: "", to: "https://humancoders-formations.s3.amazonaws.com/uploads/course/logo/15/thumb_bigger_formation-ruby.png" 
  end
end
