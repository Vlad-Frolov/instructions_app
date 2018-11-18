class User < ApplicationRecord
  has_merit
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  ratyrate_rater
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,
         :omniauth_providers => [:facebook, :google_oauth2, :vkontakte, :github]

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
      user.save
      user.name = auth.info.first_name + ' ' + auth.info.last_name
    end
  end

end
