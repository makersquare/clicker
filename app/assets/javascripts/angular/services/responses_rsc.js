app.factory("ResponsesRsc", function($resource) {
   return $resource("/question_sets/:question_sets_id/questions/:id/responses.json", 
      {question_sets_id: "@question_sets_id", id: "@id"}, 
      {update: {method: "PUT"}
    });
  });