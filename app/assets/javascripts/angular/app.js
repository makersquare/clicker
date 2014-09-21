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

app.directive('slideable', function () {
      return {
          restrict:'C',
          compile: function (element, attr) {
              // wrap tag
              var contents = element.html();
              element.html('<div class="slideable_content" style="margin:0 !important; padding:0 !important" >' + contents + '</div>');

              return function postLink(scope, element, attrs) {
                  // default properties
                  attrs.duration = (!attrs.duration) ? '1s' : attrs.duration;
                  attrs.easing = (!attrs.easing) ? 'ease-in-out' : attrs.easing;
                  element.css({
                      'overflow': 'hidden',
                      'height': '0px',
                      'transitionProperty': 'height',
                      'transitionDuration': attrs.duration,
                      'transitionTimingFunction': attrs.easing
                  });
              };
          }
      };
  })
  .directive('slideToggle', function() {
      return {
          restrict: 'A',
          link: function(scope, element, attrs) {
              var target = document.querySelector(attrs.slideToggle);
              attrs.expanded = false;
              element.bind('click', function() {
                  var content = target.querySelector('.slideable_content');
                  if(!attrs.expanded) {
                      content.style.border = '1px solid rgba(0,0,0,0)';
                      var y = content.clientHeight;
                      content.style.border = 0;
                      target.style.height = y + 'px';
                  } else {
                      target.style.height = '0px';
                  }
                  attrs.expanded = !attrs.expanded;
              });
          }
      }
  });