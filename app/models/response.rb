class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def notify
    payload = Response.connection.quote(self.to_json)
    Response.connection.raw_connection.exec("NOTIFY new_responses, #{payload}")
  end
end
