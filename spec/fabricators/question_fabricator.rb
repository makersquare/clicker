Fabricator(:question) do
  question_set_id { Faker::Number.number(5) }
end

Fabricator(:attendance_question, from: :question) do
  content { { 
            question: "Attendance Check",
            answer: 0,
            choices: [
              "true"
            ] 
          } }
  type "AttendanceQuestion"
end

Fabricator(:multi_choice_question, from: :question) do
  content { {
            question: "How many children can a node of a binary tree have?",
            answer: 3,
            choices: [
              "0",
              "1",
              "2",
              "0, 1, or 2"
            ]
          } }
  type "MultiChoiceQuestion"
end

Fabricator(:short_answer_question, from: :question) do
  content { {
            question: "What rule separates a binary search tree from a regular binary tree?",
            answer: "All children to the left of the node must be smaller than the node, and all children to the right must be larger.",
            choices: []
          } }
  type "ShortAnswerQuestion"
end