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
    verified: false,
    gravatar_id: "7194e8d48fa1d2b689f99443b767316c"
  },
  {
    provider: "github",
    uid: "456",
    name: "Rick",
    nickname: "Ricky",
    verified: false,
    gravatar_id: "7194e8d48fa1d2b689f99443b767316c"    
  },
  {
    provider: "github",
    uid: "789",
    name: "Slick",
    nickname: "Slicky",
    verified: true,
    gravatar_id: "7194e8d48fa1d2b689f99443b767316c"    
  },
  {
    provider: "github",
    uid: 5787114,
    name: "Catherine O'Neill",
    nickname: "cath-oneill",
    verified: true,
    gravatar_id: "7e907b27db9cacc618d1eba6d6142d20"
  },
  {
    provider: "github",
    uid: 17013,
    name: "Gilbert",
    nickname: "mindeavor",
    verified: true,
    gravatar_id: "44d05cf62687c3489b863e4677414ca6"
  },  
  {
    provider: "github",
    uid: 5208932,
    name:"Allison Zadrozny",
    nickname: "allizad",
    verified: true,
    gravatar_id: "8bed35854447c360ca699c164de80835"
  },
  {
    provider: "github",
    uid: 7109475,
    name: "Randy Davis",
    nickname: "RandyDavis",
    verified: true,
    gravatar_id: "879c96545b67c492653ada183c5ee487"
  },  
  {
    provider: "github",
    uid: 6164049,
    name: "Christine Oen",
    nickname: "christineoen",
    verified: true,
    gravatar_id: "7e0d908da44f0462bdd82f95d3ca38d8"
  },  
  {
    provider: "github",
    uid: 6564836,
    name: "Joseph Tingsanchali",
    nickname: "lolptdr",
    verified: true,
    gravatar_id: "4ffa8dc5f1fa98b3a7e4a1a83f0a4d56"
  },
  {
    provider: "github",
    uid: 8042304,
    name: "Brian Patterson",
    nickname: "brianpatterson",
    verified: true,
    gravatar_id: "fbdcb5e439721073314292b627ab93ee"
  },  
  {
    provider: "github",
    uid: 7033741,
    name: "Quin",
    nickname: "forwardinnovations",
    verified: true,
    gravatar_id: "c1b711e9a2c64fca2bf205f7dd11c251"
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
  },
  {
    user_id: 4,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 5,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 6,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 7,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 8,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 9,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 10,
    class_group_id: 1,
    kind: "teacher"
  },
  {
    user_id: 11,
    class_group_id: 1,
    kind: "teacher"
  }
  ])

ClassGroup.create([
  {
    name: "Cohort 8",
    description: "MakerSquare Cohort 8 Question Sets"
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
      question: "Attendance Check",
      answer: 0,
      choices: [
        "true"
      ]
    }
  }
  ])

MultiChoiceQuestion.create([
  {
    question_set_id: 1,
    content: {
      question: "How many children can a node of a binary tree have?",
      answer: 3,
      choices: [
        "0",
        "1",
        "2",
        "0, 1, or 2"
      ]
    }
  },
  {
    question_set_id: 1,
    content: {
      question: "Binary trees are cool.",
      answer: 0,
      choices: [
        "true",
        "false"
      ]
    }
  }
  ])

ShortAnswerQuestion.create([
  {
    question_set_id: 1,
    content: {
      question: "What rule separates a binary search tree from a regular binary tree?",
      answer: "All children to the left of the node must be smaller than the node, and all children to the right must be larger.",
      choices: []
    }
  }
  ])

Response.create([
  {
    question_id: 1,
    user_id: 1,
    content: {
      response: "true"
    }
  },
  {
    question_id: 2,
    user_id: 1,
    content: {
      response: "D"
    }
  },
  {
    question_id: 3,
    user_id: 1,
    content: {
      response: "I have no idea."
    }
  }
  ])

