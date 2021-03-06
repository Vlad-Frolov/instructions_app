# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  config.current_user_method = 'current_user'
end

Merit::Badge.create!({
  id: 1,
  name: 'Discoverer',
  description: "Created the first instruction",
  custom_fields: {image: "first_post.svg"}
})
Merit::Badge.create!({
  id: 2,
  name: 'Volunteer',
  description: "Created 5 instructions",
  custom_fields: {image: "five_posts.svg"}
})
Merit::Badge.create!({
  id: 3,
  name: 'Speaker',
  description: "Commented 10 times",
  custom_fields: {image: "social.svg"}
})
Merit::Badge.create!({
  id: 4,
  name: 'Stepper',
  description: "Created 7 steps in one instruction",
  custom_fields: {image: "hommie.svg"}
})

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end
