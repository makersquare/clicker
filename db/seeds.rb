# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {
    provider: "github",
    uid: "123",
    name: "Juanita",
    nickname: "Juanny",
    verified: false
  },
  {
    provider: "github",
    uid: "456",
    name: "Rick",
    nickname: "Ricky",
    verified: false
  },
  {
    provider: "github",
    uid: "789",
    name: "Slick",
    nickname: "Slicky",
    verified: true
  }
  ])

Membership.create([
  {
    user_id: 1,
    class_group_id: 1,
    kind: "student"
  },
  {
    user_id: 2,
    class_group_id: 1,
    kind: "student"
  },
  {
    user_id: 3,
    class_group_id: 1,
    kind: "teacher"
  }
  ])

ClassGroup.create([
  {
    name: "Cohort 8"
  }
  ])

QuestionSet.create([
  {
    class_group_id: 1,
    name: "Algorithms"
  }
  ])

AttendanceQuestion.create([
  {
    question_set_id: 1,
    content: {
          "question": "Attendance Check",
          "answer": true
        }
  }
  ])

MultiChoiceQuestion.create([
  {
    question_set_id: 1,
    content: {
          "question": "How many children can a node of a binary tree have?",
          "answer": "D",
          "choices": [
            {"A": "0"},
            {"B": "1"},
            {"C": "2"},
            {"D": "0, 1, or 2"}
          ]
        }
  }
  ])

TrueFalseQuestion.create([
  {
    question_set_id: 1,
    content: {
      "question": "Binary trees are cool.",
      "answer": true
    }
  }
  ])

ShortAnswerQuestion.create([
  {
    question_set_id: 1,
    content: {
          "question": "What rule separates a binary search tree from a regular binary tree?",
          "answer": "All children to the left of the node must be smaller than the node, and all children to the right must be larger."
        }
  }
  ])

Response.create([
  {
    question_id: 1,
    user_id: 1,
    content: "true"
  },
  {
    question_id: 2,
    user_id: 1,
    content: "D"
  },
  {
    question_id: 3,
    user_id: 1,
    content: "I have no idea."
  }
  ])

