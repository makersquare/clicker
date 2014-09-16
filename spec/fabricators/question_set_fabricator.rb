Fabricator(:question_set) do
  name { Faker::Company.name }
  class_group_id { Faker::Number.number(5) }
end