class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :post_id
      t.string :name
      t.text :content
      t.timestamps
    end
  end
end
