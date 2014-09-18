class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validate :content_format

  def notify
    payload = Response.connection.quote(self.to_json)
    Response.connection.raw_connection.exec("NOTIFY new_responses, #{payload}")
  end

  private

  def content_format
    response = self.content["response"]

    if self.question_set_id.blank? || self.question_set_id.class != Fixnum
      errors.add(:absent_question_set_id, "Question Set ID is absent or wrong data type")
    elsif response.blank?
      errors.add(:absent_response, "Question must not be blank")
    elsif answer.blank?
      errors.add(:absent_answer, "Answer must not be blank")
    elsif answer.to_i > self.content["choices"].count
      errors.add(:wrong_answer, "Answer must be one of the answer choices")
    end

  end
end
