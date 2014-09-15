json.array!(@responses) do |response|
  json.extract! response, :id, :question_id, :user_id, :content, :created_at, :updated_at
  json.url question_set_question_response_url(@question_set, @question, response, format: :json)
end
