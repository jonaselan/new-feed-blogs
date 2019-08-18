const fs = require('fs');
const express = require('express');

const app = express();
const port = process.env.PORT || 2000;

app.set('views', './')
app.set('view engine', 'pug')

app.get('/', (req, res) => {
  let blogs = JSON.parse(
    fs.readFileSync('blogs.json')
  );

  res.render('index', {
    title: 'New feed blogs',
    blogs
  })
});

app.listen(port, () => {
  console.log(`listening on port ${ port }`);
});