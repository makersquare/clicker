app.controller('QuestionSetCtrl', function($scope, $location, QuestionSetRsc){
 $scope.questionSets = QuestionSetRsc.query({ class_group_id: g.classGroup.id });
 $scope.setForm = false;
 $scope.addQuestionSet = function(){
  var questionSets = QuestionSetRsc.save(
    $scope.QuestionSetRsc, {
      class_group_id: g.classGroup.id, 
      name: $scope.name 
    }, function(response) {
      $scope.questionSets.push(response);
    });
  $scope.name = '';
  $location.path('/');
 };
 $scope.destroy = function(id) {
   if (confirm("Are you sure?")) {
     QuestionSetRsc.remove({ class_group_id: g.classGroup.id, id: id}, function(response){
       angular.forEach($scope.questionSets, function(e, i) {
         if(e.id === id) {
           $scope.questionSets.splice(i, 1);
           return;
         }
       });
     });
   }
 };
});