class AttendanceQuestion < Question
  validate :content_format

  private

  def content_format
    
    if self.question_set_id.blank? || self.question_set_id.class != Fixnum
      errors.add(:absent_question_set_id, "Question Set ID is absent or wrong data type")
    elsif self.content["question"].blank?
      errors.add(:absent_question, "Question must not be blank")
    elsif self.content["question"] != /^(A|a)ttendance (C|c)heck/
      errors.add(:attendance__title, "Question title must be Attendance Check")
    elsif self.content["answer"].blank?
      errors.add(:absent_answer, "Answer must not be blank")
    elsif self.content["answer"] != "true"
      errors.add(:attendance_wrong_answer, "Attendance check must be set to 'true'")
    end

  end
end
