var gulp       = require('gulp');
var gutil      = require('gulp-util');

var cssConcat  = require('gulp-concat-css');
var jshint     = require('gulp-jshint');
var stylish    = require('jshint-stylish');
var beautify   = require('gulp-js-prettify');

var browserify = require('browserify');
var source = require('vinyl-source-stream');
var AtomShellDownload = require('atom-shell-pull');

var connect = require('connect');
var http    = require('http');
var path    = require('path');
var fs      = require('fs');

var JS_FILES = ['app/js/**/*.js'];
var packageJson = require(path.join(__dirname, 'package.json'));

gulp.task('lint', ['code-clean'], function() {
    gulp.src(JS_FILES)
        // Note: the following options need to be enabled sometime later:
        // ~> es3 : true
        // ~> quotmark : 'single'
        // ~> unused : true

        // Note JSHint finds configuration options in the .jshintrc
        .pipe(jshint())
        .pipe(jshint.reporter(stylish))
        .pipe(jshint.reporter('fail'));
});

gulp.task('code-build', ['code-clean'], function() {
    process.env.NODE_PATH = path.join(__dirname, 'app')

    browserify('./app/js/main.js')
        .bundle({
            insertGlobals : true,
            ignoreMissing : true // For things like 'remote' which are atom-shell only.
        })
        .pipe(source('application.js'))
        .pipe(gulp.dest('./public/dist'));

    gulp.src('app/css/styles.css')
        .pipe(cssConcat(''))
        .pipe(gulp.dest('public/dist/styles.css'))

    // TODO: now we bundle all the Handlebars templates into one file.

});

gulp.task('code-clean', function () {
    gulp.src(JS_FILES)
        .pipe(beautify({
            preserve_newlines : false,
            jslint_happy : true,
            break_chained_methods : true,
            good_stuff : true
        }))
        .pipe(gulp.dest('app/js'));
});

gulp.task('download-shell', function () {
    var download = new AtomShellDownload({
        outputDir : 'build',
        platforms : ['linux', 'win32'],
        bits : [32, 64]
    });

    download.prepare(function (start) {
        start();
    });
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
