var gulp       = require('gulp');
var gutil      = require('gulp-util');

var browserify = require('gulp-browserify');
var cssConcat  = require('gulp-concat-css');
var jslint     = require('gulp-jslint');

var connect = require('connect');
var http    = require('http');
var path    = require('path');
var fs      = require('fs');

var JS_FILES = ['app/js/**/*.js'];

gulp.task('lint', function() {
    gulp.src(JS_FILES)
        .pipe(jslint({
            // Globals
            browser : true,
            devel : true,
            debug : false,
            node : true,
            // Lint options
            maxerr : Infinity, // To infinity and beyond!
            // maxlen : 100,
            sloppy : false,
            todo : true,
            vars : true,

            // Gulp options
            reporter : 'default',
            errorsOnly : true
        }));
});

gulp.task('web-build', function() {
    gutil.log('Building Atomic Lacuna for in the browser.');
    process.env.NODE_PATH = path.join(__dirname, 'app')
    gulp.src('app/js/main.js')
        .pipe(browserify({
            insertGlobals : true
        }))
        // For some reason, this gets exported as a folder containing the built file.
        .pipe(gulp.dest('public/dist/'));

    gulp.src('app/css/styles.css')
        .pipe(cssConcat(''))
        .pipe(gulp.dest('public/dist/styles.css'))
});

// This should be used in conjunction with the browser-build. To run the desktop
// version, do `./run.sh`.
gulp.task('server', ['web-build'], function() {
    var port = process.env.PORT || 5000;
    var app = connect()
        .use(connect.logger('dev'))
        .use(connect['static'](path.join(__dirname, 'public')));
    http.createServer(app).listen(port);
    gutil.log('Server started on port ' + port);
});