class User < ActiveRecord::Base
  has_many :class_groups, through: :memberships
  has_many :questions, through: :responses
end
