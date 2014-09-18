class QuestionSet < ActiveRecord::Base
  belongs_to :class_group
  has_many :questions, dependent: :destroy
  validates :name, presence: true
end
