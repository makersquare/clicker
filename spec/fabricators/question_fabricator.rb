Fabricator(:question) do
  question_set_id { Faker::Number.number(5) }
end

Fabricator(:attendance_question, from: :question) do
  content { { question: "Attendance Check", answer: "true" } }
  type "AttendanceQuestion"
end

Fabricator(:multi_choice_question, from: :question) do
  content { {
            question: "How many children can a node of a binary tree have?",
            answer: "D",
            choices: [
              { "A" => "0" },
              { "B" => "1" },
              { "C" => "2" },
              { "D" => "0, 1, or 2" }
            ]
          } }
  type "MultiChoiceQuestion"
end

Fabricator(:short_answer_question, from: :question) do
  content { {
            question: "What rule separates a binary search tree from a regular binary tree?",
            answer: "All children to the left of the node must be smaller than the node, and all children to the right must be larger."
          } }
  type "MultiChoiceQuestion"
end