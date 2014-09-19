//load dependencies

// var express = require('express');
// var http = require('http');
// var os = require('os');
// var path = require('path');

// //create the app
// var app = express();

// //intro test

// app.get('/', function(req,res){
//   res.send('hello world');
// });

// app.listen(4000);

var http = require('http');
var fs = require('fs');
 
/*
 * send interval in millis
 */
var sendInterval = 1000;
 
function sendServerSendEvent(req, res) {
  res.writeHead(200, {
  'Content-Type' : 'text/event-stream',
  'Cache-Control' : 'no-cache',
  'Connection' : 'keep-alive'
  });

  var sseId = (new Date()).toLocaleTimeString();

  setInterval(function() {
  writeServerSendEvent(res, sseId);
  }, sendInterval);

  writeServerSendEvent(res, sseId);
}
 
function writeServerSendEvent(res, sseId) {
  res.write('id: ' + sseId + '\n');
  res.write("data: Brian is awesome." + '\n\n');
}
 
http.createServer(function(req, res) {
  if (req.headers.accept && req.headers.accept == 'text/event-stream') {
  if (req.url == '/talk') {
  sendServerSendEvent(req, res);
  } else {
  res.writeHead(404);
  res.end();
  }
  } else {
  res.writeHead(200, {
  'Content-Type' : 'text/html'
  });
  res.write(fs.readFileSync(__dirname + '/index.html'));
  res.end();
  }
}).listen(8080);

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