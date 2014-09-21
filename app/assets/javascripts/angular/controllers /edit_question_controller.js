app.controller('EditCtrl', function($scope, $routeParams, QuestionsRsc) {
  $scope.id = g.classGroup.id;
  $scope.questionSetID = $routeParams.id;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSetID });
  $scope.questionSetName = g.classGroup.name;
  $scope.destroy = function(id) {
    if (confirm("Are you sure?")) {
      QuestionsRsc.remove({ question_sets_id: $scope.questionSetID, id: id}, function(response){
        angular.forEach($scope.questions, function(e, i) {
          if(e.id === id) {
            $scope.questions.splice(i, 1);
            return;
          }
        });
      });
    }
  };
  $scope.createQuestion = function() {
    var thisQuestion = {
      type: "MultiChoiceQuestion",
      content: {
        question: $scope.question,
        answer: $scope.answer,
        choices: [
          $scope.choiceA,
          $scope.choiceB,
          $scope.choiceC,
          $scope.choiceD
        ]
      }
    };

    var questions = QuestionsRsc.save({ question_sets_id: $scope.questionSetID, question: thisQuestion });
    // var questionSets = QuestionSet.save($scope.questionSet,{ class_group_id: g.classGroup.id, name: $scope.name }, function(response){
    $scope.questions.push(thisQuestion);
    
    $scope.question = "";
    $scope.choiceA = "";
    $scope.choiceB = "";
    $scope.choiceC = "";
    $scope.choiceD = "";
  };
});
 
app.controller('EditQuestionCtrl', function($http,$scope, $routeParams, QuestionsRsc) {
  url =  '/question_sets/' + $routeParams.question_set_id + '/questions/' + $routeParams.id;
  $http.get(url)
    .then(function(response){
    $scope.updatedquestion = response.data.content.question;
    $scope.updatedchoiceA = response.data.content.choices[0];
    $scope.updatedchoiceB = response.data.content.choices[1];
    $scope.updatedchoiceC = response.data.content.choices[2];
    $scope.updatedchoiceD = response.data.content.choices[3];
    // console.log('response',response);
  },function(err){
    console.log('error!!');
  });
  $scope.id = g.classGroup.id;
  $scope.questionSetID = $routeParams.question_set_id;

  // $scope.questionSetName = g.classGroup.name;

  $scope.updateQuestion = function() {
    var thisQuestion = {
      type: "MultiChoiceQuestion",
      content: {
        question: $scope.updatedquestion,
        answer: $scope.updatedanswer,
        choices: [
          $scope.updatedchoiceA,
          $scope.updatedchoiceB,
          $scope.updatedchoiceC,
          $scope.updatedchoiceD
        ]
      }
    };

  var questions = QuestionsRsc.update({ question_sets_id: $scope.questionSetID, id: $routeParams.id , question: thisQuestion });
  // $scope.questions.push(thisQuestion);

  // $scope.updatedquestion = "";
  // $scope.updatedchoiceA = "";
  // $scope.updatedchoiceB = "";
  // $scope.updatedchoiceC = "";
  // $scope.updatedchoiceD = "";

  };
});