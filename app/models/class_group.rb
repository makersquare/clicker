class ClassGroup < ActiveRecord::Base
  has_many :question_sets
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, :description, presence: true
end
