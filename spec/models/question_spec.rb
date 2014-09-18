require 'rails_helper'

RSpec.describe Question, :type => :model do

  describe "AttendanceQuestion's content validation" do

    let (:model) do
      AttendanceQuestion.new(
        :question_set_id => 1,
        :content => {
          :question => "Attendance Check",
          :answer => 0,
          :content => [
            "true"
          ]
        }
      )
    end

    it "validates the question key/value" do
      expect(model.question_set_id).to_not eq(nil)
      expect(model.content["question"]).to_not eq(nil)
    end
    it "validates absence of choice" do
      expect(model.content["choices"]).to eq(nil)
    end

    it "ensures the answer set to 'true'" do
      # expect(@attendance_question["content"]["answer"]).to eq(0)
      expect(model.content["answer"]).to eq(0)
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
    
    let(:model) do
      MultiChoiceQuestion.new(
        :question_set_id => 1,
        :content => {
          :question => "What is the meaning of life?",
          :answer  => 0,
          :choices => [
            "Every rose has its thorn",
            "Life is meaningless",
            "Life just is",
            "Loving, learning, earning, and realizing"
          ]
        }
      )
    end
    
    it "validates with a perfect format" do
      expect(model).to be_valid
      # expect(model).to_not be_valid
      # expect(model.errors).to have_key(:nope)

    end

    describe "Validation" do

      it "validates presence of question set id" do
        model.question_set_id = nil
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:absent_question_set_id)
      end

      it "validates the question" do
        model.content["question"] = nil
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:absent_question)
      end

      it "validates the answer" do
        model.content["answer"] = nil
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:absent_answer)
      end

      it "ensures the answer index is within the number of choices" do
        expect(model.content["answer"]).to be <= model.content["choices"].count

        model.content["answer"] = 5
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:wrong_answer)
      end
    end

    # describe "#find_choice" do
    #   it "finds a choice by .." do
    #     multi_choices_check = @multi_choice_question["content"]

    #     choices = multi_choices_check["choices"]
    #     answer = multi_choices_check["answer"]

    #     confirm = choices.map{ |x| x.keys }.flat_map{ |e| e }.find{ |i| i == answer }

    #     expect(confirm).to_not eq(nil)
    #     expect(confirm).to eq(answer)
    #   end
    # end
  end


end
