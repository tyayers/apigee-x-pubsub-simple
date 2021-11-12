const express = require('express')
const morgan = require('morgan')
const app = express()
const port = 8080

app.use(express.json()); //Used to parse JSON bodies
app.use(morgan('combined'));

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.post('/webhook', (req, res) => {
  console.log(req.url);
  console.log(req.body);
  res.send("OK");
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})