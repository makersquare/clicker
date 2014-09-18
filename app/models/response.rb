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

    if self.question_id.blank? || self.question_id.class != Fixnum
      errors.add(:absent_question_id, "Question Set ID is absent or wrong data type")
    elsif response.blank?
      errors.add(:absent_response, "Question must not be blank")
    elsif self.user_id.blank? || self.user_id.class != Fixnum
      errors.add(:absent_user_id, "User id must not be blank or wrong data type")
    end

  end
end
