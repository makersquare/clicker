class Question < ActiveRecord::Base
  belongs_to :question_set
  has_many :responses
  has_many :users, through: :responses
  accepts_nested_attributes_for :responses 
end
