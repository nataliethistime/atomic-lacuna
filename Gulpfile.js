var gulp       = require('gulp');
var gutil      = require('gulp-util');
var browserify = require('gulp-browserify');

var connect = require('connect');
var http    = require('http');
var path    = require('path');
var fs      = require('fs');

gulp.task('web-build', function() {
    gutil.log('Building Atomic Lacuna for in the browser.');
    process.env.NODE_PATH = path.join(__dirname, 'app')
    gulp.src('app/js/main.js')
        .pipe(browserify({
            insertGlobals : true
        }))
        // For some reason, this gets exported as a folder containing the built file.
        .pipe(gulp.dest('public/dist/'));
});

// This should be used in conjunction with the browser-build. To run the desktop
// version, do `./run.sh`.
gulp.task('server', ['web-build'], function() {
    var port = process.env.PORT || 5000;
    var app = connect()
        .use(connect.logger('dev'))
        // .use(connect['static'](path.join(__dirname, 'public')));
        .use(connect['static'](__dirname));
    http.createServer(app).listen(port);
    gutil.log('Server started on port ' + port);
});
