class User < ActiveRecord::Base
  has_many :memberships
  has_many :responses
  has_many :class_groups, through: :memberships
  has_many :questions, through: :responses
	
	def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.nickname = auth["info"]["nickname"]
    end
  end

  def teacher?(class_group_id)
    self.memberships.where(class_group_id: class_group_id, kind: "teacher")
    # response.empty? ? false : true
  end

  def enrolled?(class_group_id)
    response = self.memberships.where(class_group_id: class_group_id)
    response.empty? ? false : true
  end
end
