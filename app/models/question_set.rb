class QuestionSet < ActiveRecord::Base
  belongs_to :class_group
  has_many :questions
end
