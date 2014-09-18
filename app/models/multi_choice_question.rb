class MultiChoiceQuestion < Question
  validate :content_format


  # def find_choice()
    
  # end

private

  def content_format
    if self.question_set_id.blank? || self.question_set_id.class != Fixnum
      errors.add(:absent_question_set_id, "Question Set ID is absent or wrong data type")
    elsif self.content["question"].blank?
      errors.add(:absent_question, "Question must not be blank")
    elsif self.content["answer"].blank?
      errors.add(:absent_answer, "Answer must not be blank")
    elsif self.content["answer"] <= self.content["choices"].count
      errors.add(:wrong_answer, "Answer must be one of the answer choices")
    end

  end
end
