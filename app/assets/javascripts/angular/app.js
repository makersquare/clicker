var app = angular.module('app', ["ngResource", "ngRoute"]);

app.config(['$httpProvider', function(provider){
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: '/angular/edit_question_sets/display_all_question_sets.html',
        controller: 'QuestionSetCtrl'
      })
      .when('/display', {
        templateUrl: '/angular/edit_question_sets/display_all_question_sets.html',
        controller: 'QuestionSetCtrl'
      })
      .when('/qsets/:id', {
        templateUrl: '/angular/edit_question_sets/add_question.html',
        controller: 'EditCtrl'
      })
      .when('/qsets/questions/new', {
        templateUrl: '/angular/edit_question_sets/add_question.html',
        controller: 'EditCtrl'
      })
      // .when('/add_choice', {
      //   templateUrl: '/angular/edit_question_sets/add_answer_choice.html',
      //   controller: 'QuestionsCtrl'
      // })
      // .when('/show_question/:id', {
      //   templateUrl: '/angular/edit_question_sets/show_question.html',
      //   controller: 'EditQuestionCtrl'
      // })
      .when('/qsets/:question_set_id/questions/:id', {
        templateUrl: '/angular/edit_question_sets/edit_question.html',
        controller: 'EditQuestionCtrl'
      });
  });