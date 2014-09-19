app.controller('StudentViewCtrl', function($scope, QuestionSetRsc, QuestionsRsc){
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
  $scope.pieOptions = {thickness: 20, total: 100};
});