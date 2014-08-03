'use strict';

var http = require('http');

http.createServer(function(req, res) {

    var str = '';
    req.on('data', function(chunk) {
        str += chunk.toString();
    });

    req.on('end', function() {
        console.log('got some data');
        console.log(str);

        res.writeHead(200);
        res.write(str);
        res.end();
    });
}).listen(8080);
