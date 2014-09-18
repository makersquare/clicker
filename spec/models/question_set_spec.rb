require 'rails_helper'

RSpec.describe QuestionSet, :type => :model do
  
  describe 'QuestionSet' do
    it 'creates a valid class group' do
      valid_question_set = Fabricate(:question_set)
      expect(valid_question_set).to be_valid
    end

    it 'is invalid without a name' do
      invalid_question_set = QuestionSet.create(name: "")
      expect(invalid_question_set).to be_invalid
    end
  end
end