// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



var app = angular.module('app', ["ngResource"]);

app.factory("QuestionSet", function($resource) {
 return $resource("/class_groups/:id/question_sets.json", {id: "@id"}, {update: {method: "PUT"}, destroy: {method: "DELETE"}});
});

function EditCtrl($scope, $location, $routeParams, QuestionSet) {
 $scope.title = "Edit Question Set";
 $scope.questionSet = QuestionSet.get({id: $routeParams.id});

 $scope.save = function() {
   QuestionSet.update({id: $scope.questionSet.id}, $scope.questionSet, function(response){
     $location.path("/");
   });
 };
}

function NewCtrl($scope, $location, QuestionSet) {
 $scope.title = "New QuestionSet";
 $scope.questionSet = {name: "", description: ""};

 $scope.save = function() {
   var questionSets = QuestionSet.save($scope.questionSet, function(response) {
     $scope.questionSets.push(response);
     $location.path("/");
   });
 };
}

function AppCtrl($scope, $location, QuestionSet){
 $scope.questionSets = QuestionSet.query();

 $scope.destroy = function(id) {
   if (confirm("Are you sure?")) {
     QuestionSet.remove({id: id}, function(response){
       angular.forEach($scope.questionSets, function(e, i) {
         if(e.id === id) {
           $scope.questionSets.splice(i, 1);
           return;
         }
       });
     });
   }
 };
}