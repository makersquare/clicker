class ClassGroup < ActiveRecord::Base
  has_many :question_sets, dependent: :destroy
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, presence: true
end
