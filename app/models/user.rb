class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,
         :omniauth_providers => [:google_oauth2, :vkontakte]
  has_many :posts #, dependent: :destroy

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
  
end
