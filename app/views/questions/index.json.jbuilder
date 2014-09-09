json.array!(@questions) do |question|
  json.extract! question, :id, :question, :type, :choices
  json.url question_url(question, format: :json)
end
