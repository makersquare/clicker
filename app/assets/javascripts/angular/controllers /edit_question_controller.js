app.controller('EditCtrl', function($scope, $routeParams, QuestionsRsc) {
  $scope.id = g.classGroup.id;
  $scope.questionSetID = $routeParams.id;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSetID });
  $scope.questionSetName = g.classGroup.name;
  $scope.destroy = function(id) {
    if (confirm("Are you sure?")) {
            console.log("yay");
      QuestionsRsc.remove({ question_sets_id: $scope.questionSetID, id: id}, function(response){
        console.log("yup");
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
        choices: {
          A: $scope.choiceA, 
          B: $scope.choiceB, 
          C: $scope.choiceC, 
          D: $scope.choiceD 
        }
      }
    };
    var questions = QuestionsRsc.save({ question_sets_id: $scope.questionSetID, question: thisQuestion });
    // var questionSets = QuestionSet.save($scope.questionSet,{ class_group_id: g.classGroup.id, name: $scope.name }, function(response){
    // questions.push(thisQuestion); 
  };
});

app.controller('EditQuestionCtrl', function($scope, $routeParams, QuestionsRsc) {
  $scope.id = g.classGroup.id;
  $scope.questionSetID = $routeParams.id;
});