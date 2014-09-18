require 'rails_helper'

RSpec.describe Question, :type => :model do

  describe "AttendanceQuestion's content validation" do

    let (:model) do
      AttendanceQuestion.new(
        :question_set_id => 1,
        :content => {
          :question => "Attendance Check",
          :answer => 0,
          :choices => [
            "true"
          ]
        }
      )
    end

    it "validates presence of question set id" do
      model.question_set_id = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_question_set_id)
    end

    it "validates presence of question" do
      model.content["question"] = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_question)
    end

    it "validates quesiton title as Attendance Check" do
      model.content["question"] = 2298357298357
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:attendance_title)
    end

    it "validates presence of answer" do
      model.content["answer"] = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_answer)
    end
    
    it "validates the answer as true only" do
      model.content["answer"] = "false"
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:attendance_wrong_answer)
    end

  end

  describe "ShortAnswerQuestion's content validation" do

    let(:model) do
      ShortAnswerQuestion.new(
        :question_set_id => 1,
        :content => {
          :question => "What is the Coppersmith–Winograd algorithm?",
          :answer => "It was the asymptotically fastest known algorithm for square matrix multiplication until 2010.",
          :choices => []
        }
      )
    end

    it "validates presence of question set id" do
      model.question_set_id = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_question_set_id)
    end

    it "validates presence of question" do
      model.content["question"] = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_question)
    end

    it "validates presence of answer" do
      model.content["answer"] = nil
      expect(model).to_not be_valid
      expect(model.errors).to have_key(:absent_answer)
    end

    it "validates absence of choices" do
      model.content["choices"] = [
        "42",
        "Irrationalism is the absence of irrational",
        "This sentence is false"
      ]

      expect(model).to_not be_valid
      expect(model.errors).to have_key(:present_choices)
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
    end

    describe "Validation" do

      it "validates presence of question set id" do
        model.question_set_id = nil
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:absent_question_set_id)
      end

      it "validates presence of question" do
        model.content["question"] = nil
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:absent_question)
      end

      it "validates presence of answer" do
        model.content["answer"] = nil
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:absent_answer)
      end

      it "ensures the answer index is within the number of choices" do
        expect(model.content["answer"]).to be <= model.content["choices"].count

        # Now set answer to a value beyond number of choices
        model.content["answer"] = 5
        expect(model).to_not be_valid
        expect(model.errors).to have_key(:wrong_answer)
      end
    end

  end


end
