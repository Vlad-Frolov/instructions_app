class AddOmniFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :about, :string
    add_column :users, :image, :string
    add_column :users, :count_posts, :integer, default: 0
  end
end
