json.array!(@questions) do |question|
  json.extract! question, :id, :type, :content
  json.url question_set_question_url(@question_set, question, format: :json)
end
