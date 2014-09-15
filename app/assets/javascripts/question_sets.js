// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



var app = angular.module('app', ["ngResource", "ngRoute"]);

app.factory("QuestionSet", function($resource) {
 return $resource("/class_groups/:class_group_id/question_sets.json", {class_group_id: "@class_group_id"});
});

app.factory("QuestionSetDelete", function($resource) {
 return $resource("/class_groups/:class_group_id/question_sets/:id.json", {class_group_id: "@class_group_id", id: "@id"}, {update: {method: "PUT"}, destroy: {method: "DELETE"}});
});

app.config(['$httpProvider', function(provider){
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

app.controller('QuestionSetCtrl', function($scope, $location, QuestionSet, QuestionSetDelete){
 $scope.questionSets = QuestionSet.query({ class_group_id: g.classGroup.id });
 $scope.addQuestionSet = function(){
  var questionSets = QuestionSet.save($scope.questionSet,{ class_group_id: g.classGroup.id, name: $scope.name }, function(response){
    $scope.questionSets.push(response);
  });
  $scope.name = '';
 };
 $scope.destroy = function(id) {
   if (confirm("Are you sure?")) {
     QuestionSetDelete.remove({ class_group_id: g.classGroup.id, id: id}, function(response){
       angular.forEach($scope.questionSets, function(e, i) {
         if(e.id === id) {
           $scope.questionSets.splice(i, 1);
           return;
         }
       });
     });
   }
 };
}).controller('EditCtrl', function($scope) {
  $scope.id = g.classGroup.id;
});

// app.controller('QuestionsCtrl', function($scope){

// });


app.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: '/angular/main.html',
      controller: 'AppCtrl'
    })
    .when('/edit', {
      templateUrl: '/angular/edit.html',
      controller: 'EditCtrl'
    })
    .when('/questions', {
      templateUrl: '../angular/questions.html',
      controller: 'QuestionsCtrl'
    });
});
