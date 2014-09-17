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

  describe "AttendanceQuestion's content validation" do
    it "validates the question key/value" do
      attendance_check = @attendance_question["content"]["question"] 

      expect(@attendance_question.question_set_id).to eq(@question_set.id)
      expect(attendance_check).to_not eq(nil)
    end
    it "validates absence of choice" do
      expect(@attendance_question["content"]["choices"]).to eq(nil)
    end

    it "ensures the answer set to 'true'" do
      expect(@attendance_question["content"]["answer"]).to eq("true")
    end
  end

  describe "ShortAnswerQuestion's content validation" do
    it "validates the question key/value" do
      short_answer_check = @short_answer_question["content"]

      expect(@short_answer_question.question_set_id).to eq(@question_set.id)
      expect(short_answer_check).to_not eq(nil)
    end
    it "validates absence of choice" do
      expect(@short_answer_question["content"]["choices"]).to eq(nil)
    end
    it "ensures the answer is present" do
      expect(@short_answer_question["content"]["answer"]).to_not eq(nil)
    end
  end

  describe "MultiChoiceQuestion's content validation" do
    it "validates the question key/value" do
      multi_choice_check = @multi_choice_question["content"]

      expect(@multi_choice_question.question_set_id).to eq(@question_set.id)
      expect(multi_choice_check).to_not eq(nil)
    end
    it "validates the choices key/value" do
      multi_choices = @multi_choice_question["content"]["choices"]

      expect(multi_choices).to_not eq(nil)

      multi_choices_keys = multi_choices.map { |x| x.keys }
      multi_answers = multi_choices.map { |x| x.values }

      expect(multi_choices_keys.count).to eq(multi_answers.count)
    end

    it "ensures the answer index is within the number of choices" do
      multi_choices_check = @multi_choice_question["content"]

      choices = multi_choices_check["choices"]
      answer = multi_choices_check["answer"]

      confirm = choices.map{ |x| x.keys }.flat_map{ |e| e }.find{ |i| i == answer }

      expect(confirm).to_not eq(nil) 
    end
  end


end
