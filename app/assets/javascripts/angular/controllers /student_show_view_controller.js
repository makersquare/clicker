app.controller('StudentViewCtrl', function($scope, QuestionSetRsc){
  $scope.questionSets = QuestionSetRsc.query({ class_group_id: g.classGroup.id });

});