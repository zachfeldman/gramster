class User < ActiveRecord::Base
  def email_required?
    super && provider.blank?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:instagram]

  def self.find_or_create_for_instagram_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.nickname
        user.password = Devise.friendly_token[0,20]
    end
  end

  alias_attribute :username, :email
end
