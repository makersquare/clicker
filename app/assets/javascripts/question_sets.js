// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



var app = angular.module('app', ["ngResource", "ngRoute"]);

app.factory("QuestionSet", function($resource) {
   return $resource("/class_groups/:class_group_id/question_sets.json", {class_group_id: "@class_group_id"});
  })
  .factory("QuestionSetDelete", function($resource) {
   return $resource("/class_groups/:class_group_id/question_sets/:id.json", {class_group_id: "@class_group_id", id: "@id"}, {update: {method: "PUT"}, destroy: {method: "DELETE"}});
  })
  .factory("AllQuestions", function($resource) {
    return $resource("/question_sets/:question_sets_id/questions.json", {question_sets_id: "@question_sets_id"});
  })
  .factory("AllQuestionsDelete", function($resource) {
    return $resource("/question_sets/:question_sets_id/questions/:id.json", {
      question_sets_id: "@question_sets_id",
      id: "@id"
    }, {
      update: {method: "PUT"},
      destroy: {method: "DELETE"}
    });
  });

app.config(['$httpProvider', function(provider){
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

app.controller('AppCtrl', function($scope, $location, QuestionSet, QuestionSetDelete){
 $scope.questionSets = QuestionSet.query({ class_group_id: g.classGroup.id });
 $scope.addQuestionSet = function(){
  var questionSets = QuestionSet.save(
    $scope.questionSet, {
      class_group_id: g.classGroup.id, 
      name: $scope.name 
    }, function(response) {
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
}).controller('EditCtrl', function($scope, $routeParams, AllQuestions, AllQuestionsDelete) {
  $scope.id = g.classGroup.id;
  $scope.questionSetID = $routeParams.id;
  $scope.questions = AllQuestions.query({ question_sets_id: $scope.questionSetID });
  $scope.questionSetName = g.classGroup.name;
  $scope.destroy = function(id) {
    if (confirm("Are you sure?")) {
            console.log("yay");
      AllQuestionsDelete.remove({ question_sets_id: $scope.questionSetID, id: id}, function(response){
        console.log("yup");
        angular.forEach($scope.questions, function(e, i) {
          if(e.id === id) {
            $scope.questions.splice(i, 1);
            return;
          }
        });
      });
    }
  };
  $scope.createQuestion = function() {
    var thisQuestion = {
      type: "MultiChoiceQuestion", 
      content: {
        question: $scope.question, 
        choices: {
          A: $scope.choiceA, 
          B: $scope.choiceB, 
          C: $scope.choiceC, 
          D: $scope.choiceD 
        }
      }
    };
    var questions = AllQuestions.save({ question_sets_id: $scope.questionSetID, question: thisQuestion });
    // var questionSets = QuestionSet.save($scope.questionSet,{ class_group_id: g.classGroup.id, name: $scope.name }, function(response){
    questions.push(thisQuestion); 
  };
});

app.controller('QuestionsCtrl', function($scope, AllQuestions, $routeParams){
  $scope.addQuestion = function(){
   var questions = AllQuestions.save($scope.question,{ class_group_id: g.classGroup.id, question: $scope.question }, function(response){
     $scope.questions.push(response);
   });
   $scope.question = '';
   $scope.questionRoute = "hello";
   $scope.hello = $routeParams.id;
  };
});


app.config(function ($routeProvider) {
  $routeProvider
    .when('/', {
      templateUrl: '/angular/display_all_question_sets.html',
      controller: 'AppCtrl'
    })
    // .when('/edit/:id', {
    //   templateUrl: '/angular/edit_intro_question.html',
    //   controller: 'EditCtrl'
    // })
    .when('/edit/:id', {
      templateUrl: '/angular/add_question.html',
      controller: 'EditCtrl'
    })
    // .when('/questions', {
    //   templateUrl: '../angular/questions.html',
    //   controller: 'QuestionsCtrl'
    // })
    .when('/add', {
      templateUrl: '/angular/add_question_set.html',
      controller: 'QuestionsCtrl'
    })
    .when('/add_question', {
      templateUrl: '/angular/add_question.html',
      controller: 'EditCtrl'
    })
    .when('/add_choice', {
      templateUrl: '/angular/add_answer_choice.html',
      controller: 'QuestionsCtrl'
    });
});
