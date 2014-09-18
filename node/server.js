//load dependencies

var express = require('express');
var http = require('http');
var os = require('os');
var path = require('path');

//create the app
var app = express();

//intro test

app.get('/', function(req,res){
  res.send('hello world');
});

app.listen(4000);

//introductory configuration

// app.configure(function(){
//   app.set('port', process.env.PORT || 4000);
//   app.use(express.favicon());
//   app.use(express.logger('dev'));
//   app.use(express.bodyParser());
//   app.use(express.methodOverride());
//   app.use(app.router);
// });

//simple standard errorhandler
// app.configure('development', function(){
//   app.use(express.errorHandler());
// });

// App start!

// var openConnections = [];

//startup everything
// http.createServer(app).listen(app.get('port'), function(){
//   console.log("Express server listening on port "+ app.get('port'));
// });