app.controller('TeacherViewCtrl', function($scope, QuestionSetRsc, QuestionsRsc){
  $scope.questionSet = p.questionSet;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSet.id });
  $scope.showTab = 0;
  $scope.setTab = function(num){
    $scope.showTab = num;
  };
 });