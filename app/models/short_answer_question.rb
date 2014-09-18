class ShortAnswerQuestion < Question
  validate :content_format

  private

  def content_format
    question = self.content["question"]
    answer = self.content["answer"]
    
    if self.question_set_id.blank? || self.question_set_id.class != Fixnum
      errors.add(:absent_question_set_id, "Question Set ID is absent or wrong data type")
    elsif question.blank?
      errors.add(:absent_question, "Question must not be blank")
    elsif answer.blank?
      errors.add(:absent_answer, "Answer must not be blank")
    elsif self.content["choices"].present?
      errors.add(:present_choices, "Short answer choices must not be present")
    end

  end
end
