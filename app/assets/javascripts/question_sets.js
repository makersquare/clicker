// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



var app = angular.module('app', ["ngResource"]);

app.factory("QuestionSet", function($resource) {
 return $resource("/class_groups/:class_group_id/question_sets.json", {class_group_id: "@class_group_id"}, {update: {method: "PUT"}, destroy: {method: "DELETE"}});
});

app.config(['$httpProvider', function(provider){
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

// app.config(["$httpProvider", function($httpProvider) {
//    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
//  }
// ]);

// app.factory("NewQuestionSet", function($resource {
//   return $resource("/class_groups/:class_group_id/question_set.json", {class_group_id: "@class_group_id", }, {update: {method: "PUT"}, destroy: {method: "DELETE"}});
// });

// function EditCtrl($scope, $location, $routeParams, QuestionSet) {
//  $scope.title = "Edit Question Set";
//  $scope.questionSet = QuestionSet.get({id: $routeParams.id});

//  $scope.save = function() {
//    QuestionSet.update({id: $scope.questionSet.id}, $scope.questionSet, function(response){
//      $location.path("/");
//    });
//  };
// }

// function NewCtrl($scope, $location, QuestionSet) {
//  $scope.title = "New QuestionSet";
//  $scope.questionSet = {name: "", description: ""};

//  $scope.save = function() {
//    var questionSets = QuestionSet.save($scope.questionSet, function(response) {
//      $scope.questionSets.push(response);
//      $location.path("/");
//    });
//  };
// }
app.controller('AppCtrl', function($scope, $location, QuestionSet){
 $scope.questionSets = QuestionSet.query({ class_group_id: g.classGroup.id });
 $scope.addQuestionSet = function(){
  var questionSets = QuestionSet.save($scope.questionSet,{ class_group_id: g.classGroup.id }, function(response){
    $scope.questionSets.push(response);
  });
 };
 // $scope.destroy = function(id) {
 //   if (confirm("Are you sure?")) {
 //     QuestionSet.remove({id: id}, function(response){
 //       angular.forEach($scope.questionSets, function(e, i) {
 //         if(e.id === id) {
 //           $scope.questionSets.splice(i, 1);
 //           return;
 //         }
 //       });
 //     });
 //   }
 // };
});