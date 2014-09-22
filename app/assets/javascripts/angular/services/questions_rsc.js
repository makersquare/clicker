app.factory("QuestionsRsc", function($resource) {
    return $resource("/question_sets/:question_sets_id/questions/:id.json", 
      {question_sets_id: "@question_sets_id", id: "@id"}, 
      {update: {method: "PUT"}
    });
  });