
const express = require('express');
const app = express();

app.get('/puppet', (req, res) => {
  res.send('Hello from App Server 2!');
});

app.listen(3000, '0.0.0.0', () => {
  console.log('App Server 2 running on port 3000');
});
