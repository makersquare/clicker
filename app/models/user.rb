class User < ActiveRecord::Base
  has_many :class_groups, through: :membership
  has_many :questions, through: :responses
end
