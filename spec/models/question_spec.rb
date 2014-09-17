require 'rails_helper'

RSpec.describe Question, :type => :model do

  before do
    # request.env["HTTP_ACCEPT"] = 'application/json'
    @question_set = Fabricate(:question_set, questions: 
      [
        Fabricate(:attendance_question), 
        Fabricate(:short_answer_question), 
        Fabricate(:multi_choice_question)
      ]
    )
  end

  describe 'question model association' do
    it "belongs to same question set id" do
# binding.pry
    expect(@question_set.questions.count).to eq(3)
    end
  end


end
