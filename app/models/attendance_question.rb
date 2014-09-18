class AttendanceQuestion < Question
  validate :content_format

  private

  def content_format
    question = self.content["question"]
    answer = self.content["answer"]

    if self.question_set_id.blank? || self.question_set_id.class != Fixnum
      errors.add(:absent_question_set_id, "Question Set ID is absent or wrong data type")
    elsif question.blank?
      errors.add(:absent_question, "Question must not be blank")
    elsif !question.is_a?(String)
      errors.add(:attendance_title, "You must enter an Attendance Question/Phrase")
    elsif answer.blank?
      errors.add(:absent_answer, "Answer must not be blank")
    elsif answer != 0
      errors.add(:attendance_wrong_answer, "Attendance check must be set to 'true'")
    end

  end
end
