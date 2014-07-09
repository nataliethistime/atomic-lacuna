var gulp       = require('gulp');
var gutil      = require('gulp-util');

var cssConcat  = require('gulp-concat-css');
var jslint     = require('gulp-jslint');

var browserify = require('browserify');
var source = require('vinyl-source-stream');

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
            maxerr : 30,
            sloppy : false,
            todo : true,
            vars : true,
            nomen : true, // Allow _'s in variable names. (we use Underscore here)

            // Gulp options
            reporter : 'default',
            errorsOnly : true
        }));
});

gulp.task('code-build', function() {
    process.env.NODE_PATH = path.join(__dirname, 'app')

    browserify('./app/js/main.js')
        .bundle({
            insertGlobals : true
        })
        .pipe(source('application.js'))
        .pipe(gulp.dest('./public/dist'));

    gulp.src('app/css/styles.css')
        .pipe(cssConcat(''))
        .pipe(gulp.dest('public/dist/styles.css'))

    // TODO: now we bundle all the Handlebars templates into one file.

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
