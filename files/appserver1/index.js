
const express = require('express');
const app = express();

app.get('/ansible', (req, res) => {
  res.send('Hello from App Server 1!');
});

app.listen(3000, '0.0.0.0', () => {
  console.log('App Server 1 running on port 3000');
});

