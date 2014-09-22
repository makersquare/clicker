app.controller('StudentViewCtrl', function($scope, QuestionSetRsc, QuestionsRsc, ResponsesRsc){
  $scope.questionSet = p.questionSet;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSet.id }, function() {
    $scope.questions = $scope.questions.sort(function(a, b) {
      if (a.created_at < b.created_at) {
        return -1;
      } else if (a.created_at > b.created_at) {
        return 1;
      } else {
        return 0;
      }
    });
  });  
  $scope.showTab = 0;
  $scope.setTab = function(num){
    $scope.showTab = num;
  };
  var teal = '#54BC9E';
  var violet = '#5854D3';
  var rose = '#C95073';
  var cloud = '#ecf0f1';
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