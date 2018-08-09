class CreatePostCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :user, index: true
      t.text :img_url, null: false, default: "" 
      t.timestamps
    end
    
    create_table :categories do |t|
      t.string :name, null: false, default: ""
      t.timestamps
    end
  
    create_table :post_categories, id: false do |t|
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true
      t.timestamps
    end
  end
end
