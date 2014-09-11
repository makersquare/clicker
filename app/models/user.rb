class User < ActiveRecord::Base
  has_many :memberships
  has_many :responses
  has_many :class_groups, through: :memberships
  has_many :questions, through: :responses
	
	def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
    end
  end

end
