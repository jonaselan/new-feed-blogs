const http = require('http');
const json2html = require('node-json2html');
const fs = require('fs');

function buildHtml(req) {
  var t = {'<>':'div','html':'${title} ${year}'};

  let rawdata = fs.readFileSync('test.json');
  let d = JSON.parse(rawdata);

  var body = json2html.transform(d, t);

  return '<!DOCTYPE html> \
            <html> \
              <body>' + body + '</body> \
            </html>';
};

http.createServer(function (req, res) {
  var html = buildHtml(req);

  res.writeHead(200, {
    'Content-Type': 'text/html',
    'Content-Length': html.length,
    'Expires': new Date().toUTCString()
  });
  res.end(html);
}).listen(8085);