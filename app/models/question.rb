class Question < ActiveRecord::Base
  belongs_to :question_set
  has_many :users, through: :responses
end
