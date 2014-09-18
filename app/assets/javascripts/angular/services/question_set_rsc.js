app.factory("QuestionSetRsc", function($resource) {
   return $resource("/class_groups/:class_group_id/question_sets/:id.json", 
      {class_group_id: "@class_group_id", id: "@id"}, 
      {update: {method: "PUT"}
    });
  });