class Question < ActiveRecord::Base
  belongs_to :question_set
  has_many :users, through: :responses
end

class AttendanceQuestion < Question
end

class MultiChoiceQuestion < Question
end

class TrueFalseQuestion < Question
end

class ShortAnswerQuestion < Question
end
