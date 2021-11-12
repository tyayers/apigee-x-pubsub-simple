const express = require('express')
const morgan = require('morgan')
const path = require('path');

const app = express()
const port = 8080

app.use(express.json()); //Used to parse JSON bodies
app.use(morgan('combined'));
app.use(express.static('public'));

let clients = [];
const messages = [];

app.post('/webhook', addMessage);

function sendEventsToAll(newMessage) {
  clients.forEach(client => client.response.write(`data: ${JSON.stringify(newMessage)}\n\n`))
}

async function addMessage(request, respsonse, next) {
  const newMessage = request.body.message;
  messages.push(newMessage);
  respsonse.send("OK");
  return sendEventsToAll(newMessage);
}

function eventsHandler(request, response, next) {
  const headers = {
    'Content-Type': 'text/event-stream',
    'Connection': 'keep-alive',
    'Cache-Control': 'no-cache'
  };
  response.writeHead(200, headers);

  const data = `data: ${JSON.stringify(messages)}\n\n`;

  response.write(data);

  const clientId = Date.now();

  const newClient = {
    id: clientId,
    response
  };

  clients.push(newClient);

  request.on('close', () => {
    console.log(`${clientId} Connection closed`);
    clients = clients.filter(client => client.id !== clientId);
  });
}

app.get('/events', eventsHandler);

// Handles any requests that don't match the ones above
app.get('*', (req,res) =>{
  res.sendFile(path.join(__dirname + '/../public/index.html'));
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})