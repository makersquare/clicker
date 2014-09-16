Fabricator(:response) do
  content { { response: "Here's my answer!" } }
  question_id {Faker::Number.number(5)}
  user_id {Faker::Number.number(5)}
end