app.controller('StudentViewCtrl', function($scope, QuestionSetRsc, QuestionsRsc){
  $scope.questionSet = p.questionSet;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSet.id });
  $scope.showTab = 0;
  var teal = '#54BC9E';
  var violet = '#5854D3';
  var rose = '#C95073';
  var cloud = '#ecf0f1';
  $scope.setTab = function(num){
    $scope.showTab = num;
  };
  $scope.pieChartData = [
      {label: "A", value: 10, color: teal, total: 100}, 
      {label: "B", value: 5, color: violet, total: 100},
      {label: "C", value: 4, color: rose, total: 100},
      {label: "D", value: 4, color: cloud, total: 100},
    ];
  $scope.pieOptions = {
    thickness: 40
  };
});