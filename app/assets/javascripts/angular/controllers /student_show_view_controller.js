app.controller('StudentViewCtrl', function($scope, QuestionSetRsc, QuestionsRsc, ResponsesRsc){
  $scope.questionSet = p.questionSet;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSet.id });
  $scope.showTab = 0;
  $scope.setTab = function(num){
    $scope.showTab = num;
  };
  $scope.pieChartData = [
      {label: "A", value: 10, color: "red", total: 100}, 
      {label: "B", value: 5, color: "black", total: 100},
      {label: "C", value: 4, color: "blue", total: 100}
    ];
  $scope.pieOptions = {
    thickness: 10
  };
  $scope.submitResponse = function(question_id, choice) {
    $scope.responses = ResponsesRsc.query({question_sets_id: $scope.questionSet.id, id: question_id});
    
    var submittedResponse = ResponsesRsc.save({question_sets_id: $scope.questionSet.id, id: question_id}, {
      content: {
        response: choice
      }
    });

    $scope.responses.push(submittedResponse);
  };
});