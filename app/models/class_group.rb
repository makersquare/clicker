class ClassGroup < ActiveRecord::Base
  has_many :question_sets
  has_many :users, through: :memberships
end
