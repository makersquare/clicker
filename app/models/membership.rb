class Membership < ActiveRecord::Base
  belongs_to :users
  belongs_to :class_group
end
