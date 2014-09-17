require 'rails_helper'

RSpec.describe Question, :type => :model do

  before do
    @question_set = Fabricate(:question_set, questions: 
      [
        Fabricate(:attendance_question), 
        Fabricate(:short_answer_question), 
        Fabricate(:multi_choice_question)
      ]
    )

    @attendance_question = @question_set.questions[0]
    @short_answer_question = @question_set.questions[1]
    @multi_choice_question = @question_set.questions[2]
  end

  describe 'Question Model Association' do
    it "belongs to same question_set_id" do
      attendance_qset_id = @attendance_question.question_set_id
      short_ans_qset_id = @short_answer_question.question_set_id
      multi_choice_qset_id = @multi_choice_question.question_set_id

      expect(attendance_qset_id).to eq(@question_set.id)
      expect(short_ans_qset_id).to eq(@question_set.id)
      expect(multi_choice_qset_id).to eq(@question_set.id)
    end

  end

  describe 'AttendanceQuestion' do

    it "is an instance of AttendanceQuestion class" do
      expect(@attendance_question).to be_a(AttendanceQuestion) 
    end

    it "contains the word 'attendance check'" do
      attendance_question_title = @attendance_question.content["question"]
      
      expect(attendance_question_title).to match(/^(A|a)ttendance (C|c)heck/) 
    end

    it "has only one answer as 'true'" do
      attendance_answer = @attendance_question.content["answer"]

      expect(attendance_answer).to eq("true")
    end
  end

  describe 'ShortAnswerQuestion' do

    it "is an instance of ShortAnswerQuestion class" do
      expect(@short_answer_question).to be_a(ShortAnswerQuestion) 
    end

    it "contains an answer of any variable type" do
      answer = @short_answer_question.content["answer"]

      expect(answer).to_not eq(nil)
    end
  end

  describe 'MultiChoiceQuestion' do

    it "is an instance of MultiChoiceQuestion class" do
      expect(@multi_choice_question).to be_a(MultiChoiceQuestion) 
    end

    it "contains at least one choice with corresponding answer" do
      multi_choices = @multi_choice_question.content["choices"].map do |x|
        x.keys
      end
      multi_answers = @multi_choice_question.content["choices"].map do |x|
        x.values
      end

      expect(multi_choices).to_not eq(nil)
      expect(multi_answers).to_not eq(nil)
      expect(multi_choices.count).to eq(multi_answers.count)
    end
  end

end
