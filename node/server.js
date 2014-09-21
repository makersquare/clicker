//load dependencies

var http = require('http');
var fs = require('fs');
var pg = require('pg');
var sessionDecoder = require('rails-session-decoder');

//rails session decoder

var secret = '097279fd06c7c2fa479479492ffb2e48156f4ae780d0a31ab191f184ff4da695d3177843d8313e34e87fa31568170ac5a8d396b8ec7dc973d7fa8937c7605fa7';
var decoder = sessionDecoder(secret);

// cookie parsing function
function readCookie(name, cookie) {
  var nameEQ = name + "=";
  var ca = cookie.split(';');
  for(var i=0;i < ca.length;i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1,c.length);
    if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}

//postgres connections code

var client = new pg.Client(process.env.DATABASE_URL);

client.connect();
client.on('notification', function(msg){
  console.log(msg.channel);
  console.log(msg.payload);
});
client.query("LISTEN new_responses");
 
// Server Sent Events Code

var sendInterval = 1000;
var currentSessions = {};
 
function sendServerSentEvent(req, res) {
  res.writeHead(200, {
  'Content-Type' : 'text/event-stream',
  'Cache-Control' : 'no-cache',
  'Connection' : 'keep-alive',
  'Access-Control-Allow-Origin': 'http://app.clicker.dev',
  'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE,OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, Content-Length, X-Requested-With, Cookie',
  'Access-Control-Allow-Credentials': true
  });

  // Gets cookie into the node server from the rails server and parses
  var cookie = readCookie("_clicker_session", req.headers.cookie);

  //Decodes said cookie using rails session decoder set above
  try {
    decoder.decodeCookie(cookie, function(err, sessionData){
      console.log(sessionData);
      sessionData = JSON.parse(sessionData);
      currentSessions[sessionData.user_id] = true;
      console.log(currentSessions);
    });
  }
  catch(err) {
    console.log("Cookie Error", err);
  }

  var sseId = (new Date()).toLocaleTimeString();

  setInterval(function() {
  writeServerSentEvent(res, sseId, currentSessions);
  }, sendInterval);

  writeServerSentEvent(res, sseId, currentSessions);
}
 
function writeServerSentEvent(res, sseId, currentSessions) {
  res.write('id: ' + sseId + '\n');
  res.write("data: "+ JSON.stringify(currentSessions) + '\n\n');
}

//creates server
 
http.createServer(function(req, res) {
  if (req.headers.accept && req.headers.accept == 'text/event-stream') {
  if (req.url == '/test') {
  sendServerSentEvent(req, res);
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
