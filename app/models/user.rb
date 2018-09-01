class User < ApplicationRecord
  has_merit
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  ratyrate_rater
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,
         :omniauth_providers => [:facebook, :google_oauth2, :vkontakte, :github]

  # providers => {:vkontakte_from_omniauth, :facebook_from_omniauth, :from_omniauth, :google_from_omniauth}
  # scope providers, -> (auth) do 
  #     self.authorize(auth)
  #   end

  def self.google_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.name = auth.info.name
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.image = auth.info.image
    user.save
    end
  end

  def self.vkontakte_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.first_name + '_' + auth.info.last_name + '@vk.com'
    user.password = Devise.friendly_token[0,20]
    user.image = auth.info.image
    user.name = auth.info.first_name + ' ' + auth.info.last_name
    user.save
    end
  end

  def self.facebook_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
      user.name = auth.info.name 
      user.save
    end
  end

 def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.image = auth.info.image
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      # user.oauth_token = auth.credentials.token
      user.save
    end
  end
  
end
