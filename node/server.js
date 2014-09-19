//load dependencies

var http = require('http');
var fs = require('fs');
var pg = require('pg');

//postgres connections code

var client1 = new pg.Client(process.env.DATABASE_URL);

client1.connect();
client1.on('notification', function(msg){
  console.log(msg.channel);
  console.log(msg.payload);
});
client1.query("LISTEN new_responses");
 
// Server Sent Events Code

var sendInterval = 1000;

var psqlnotify = "test";
 
function sendServerSendEvent(req, res) {
  res.writeHead(200, {
  'Content-Type' : 'text/event-stream',
  'Cache-Control' : 'no-cache',
  'Connection' : 'keep-alive'
  });

  var sseId = (new Date()).toLocaleTimeString();

  setInterval(function() {
  writeServerSendEvent(res, sseId, psqlnotify);
  }, sendInterval);

  writeServerSendEvent(res, sseId, psqlnotify);
}
 
function writeServerSendEvent(res, sseId, data) {
  res.write('id: ' + sseId + '\n');
  res.write("data: "+ data + '\n\n');
}

//creates server
 
http.createServer(function(req, res) {
  if (req.headers.accept && req.headers.accept == 'text/event-stream') {
  if (req.url == '/test') {
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
}).listen(4000);
