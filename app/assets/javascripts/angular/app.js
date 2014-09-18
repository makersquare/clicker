var app = angular.module('app', ["ngResource", "ngRoute"]);

app.config(['$httpProvider', function(provider){
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: '/angular/display_all_question_sets.html',
        controller: 'QuestionSetCtrl'
      })
      .when('/edit/:id', {
        templateUrl: '/angular/add_question.html',
        controller: 'EditCtrl'
      })
      .when('/add_question', {
        templateUrl: '/angular/add_question.html',
        controller: 'EditCtrl'
      })
      .when('/add_choice', {
        templateUrl: '/angular/add_answer_choice.html',
        controller: 'QuestionsCtrl'
      })
      .when('/show_question/:id', {
        templateUrl: '/angular/show_question.html',
        controller: 'EditQuestionCtrl'
      });
  });