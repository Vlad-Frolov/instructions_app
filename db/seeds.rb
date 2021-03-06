# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def seed_users
    user_id = 0
    10.times do 
      User.create(
        name: "test#{user_id}",
        email: "test#{user_id}@test.com",
        password: '123456',
        password_confirmation: '123456'
      )
      user_id = user_id + 1
    end
  end
  
  
  def seed_categories
    hobby = ['Arts', 'Crafts', 'Sports', 'Sciences', 'Collecting', 'Reading', 'Other']
    
    hobby.each do |name|
      Category.create(name: name)
    end
  end
  
  def seed_posts
      5.times do
        Post.create(
          title: Faker::Lorem.sentences[0], 
          content: Faker::Lorem.sentences[0], 
          user_id: rand(1..9), 
          category_id: 2,
          img_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO3iaWZXuJ5iizhuMBYB7r8SFpkEmr2DhMQ9-QIYELl8G1QD_I'
        )
    end
  end

  # def seed_post_categories
  #   posts = Post.all 
    
  #   posts.each do |post| 
  #     rand(1..4).times do 
  #       PostCategory.create( 
  #         post_id: rand(1..4), 
  #         category_id: rand(1..15) 
  #       ) 
  #   end 
  #  end 
  # end
  
  # seed_users
  seed_categories
  # seed_posts
  # seed_post_categories
  