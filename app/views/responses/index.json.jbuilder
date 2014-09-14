json.array!(@responses) do |response|
  json.extract! response, :id, :content
  json.url question_set_question_responses_url(@question_set, @question, response, format: :json)
end
