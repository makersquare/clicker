app.controller('TeacherViewCtrl', function($scope, QuestionSetRsc, QuestionsRsc, ResponsesRsc){
  $scope.questionSet = p.questionSet;
  $scope.questions = QuestionsRsc.query({ question_sets_id: $scope.questionSet.id }, function() {
    $scope.questions = $scope.questions.sort(function(a, b) {
      if (a.created_at < b.created_at) {
        return -1;
      } else if (a.created_at > b.created_at) {
        return 1;
      } else {
        return 0;
      }
    });
  });
  $scope.showTab = 0;
  // colors for pie charts
  var teal = '#54BC9E';
  var violet = '#5854D3';
  var rose = '#C95073';
  var cloud = '#ecf0f1';
  
  $scope.setTab = function(num){
    $scope.showTab = num;
  };

  $scope.openQuestion = function(questionID) {
    var thisQuestion = {
      state: "open"
    };
    var question = QuestionsRsc.update({question_sets_id: $scope.questionSet.id, id: questionID, question: thisQuestion});
  };

  $scope.closeQuestion = function(questionID) {
    var thisQuestion = {
      state: "closed"
    };
    var question = QuestionsRsc.update({question_sets_id: $scope.questionSet.id, id: questionID, question: thisQuestion});
  };

  $scope.findResponses = function(questionID) {
    ResponsesRsc.query({question_sets_id: $scope.questionSet.id, id: questionID});
  };
  // $scope.responses = ResponsesRsc.query({question_sets_id: $scope.questionSet.id, id: $scope.questions.id});
  // HOW DO I GET THE ID OF THE QUESTIONS, OMG UGHHHHHHHH.... That is how you do it above ^^^^^^^^^^^^^^, but 
  // it needs to read $scope.questions !!![ID OF QUESTION]!!! .id        ........maybe through the repeat??? ugh.
 });