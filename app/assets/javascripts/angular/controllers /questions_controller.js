app.controller('QuestionsCtrl', function($scope, AllQuestions){
  $scope.addQuestion = function(){
   var questions = AllQuestions.save($scope.question,{ class_group_id: g.classGroup.id, question: $scope.question }, function(response){
     $scope.questions.push(response);
   });
   $scope.question = '';
  };
});