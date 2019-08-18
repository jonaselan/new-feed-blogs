const fs = require('fs');
// setup express
const express = require('express');
const app = express();
const port = process.env.PORT || 2000;

// setup pug
app.set('views', './')
app.set('view engine', 'pug')

// set route
app.get('/', (req, res) => {
  let blogs = JSON.parse(
    fs.readFileSync('blogs.json')
  );

  res.render('index', {
    title: 'New feed blogs',
    blogs
  })
});

// serve up
app.listen(port, () => {
  console.log(`listening on port ${ port }`);
});