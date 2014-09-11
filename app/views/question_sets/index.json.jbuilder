json.array!(@question_sets) do |question_set|
  json.extract! question_set, :id, :name
  json.url class_group_question_set_url(@class_group, question_set, format: :json)
end
