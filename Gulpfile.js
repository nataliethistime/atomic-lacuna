var gulp       = require('gulp');
var gutil      = require('gulp-util');

var cssConcat  = require('gulp-concat-css');
var jshint     = require('gulp-jshint');
var stylish    = require('jshint-stylish');
var beautify   = require('gulp-js-prettify');
var handlebars = require('gulp-handlebars');
var defineModule = require('gulp-define-module');
var declare = require('gulp-declare');
var concat = require('gulp-concat');
var cleanHTML = require('gulp-cleanhtml');

var browserify = require('browserify');
var source = require('vinyl-source-stream');
var AtomShellDownload = require('atom-shell-pull');
var _ = require('lodash');

var connect = require('connect');
var http    = require('http');
var path    = require('path');
var fs      = require('fs');

var JS_FILES = ['app/js/**/*.js'];
var packageJson = require(path.join(__dirname, 'package.json'));

gulp.task('lint', function() {
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

gulp.task('code-build', function() {
    process.env.NODE_PATH = path.join(__dirname, 'app')

    browserify('./app/js/main.js')
        .bundle({
            insertGlobals : true,
            ignoreMissing : true // For things like 'remote' which are atom-shell only.
        })
        .pipe(source('browser-build.js'))
        .pipe(gulp.dest('./public/dist'));

    gulp.src('app/css/styles.css')
        .pipe(cssConcat(''))
        .pipe(gulp.dest('public/dist/styles.css'))

    // Bundle all the Handlebars templates into one file.
    gulp.src('./app/templates/**/*.hbs')
        .pipe(cleanHTML())
        .pipe(handlebars())
        .pipe(defineModule('plain'))
        .pipe(declare({
            namespace : 'ATOMIC_LACUNA_TEMPLATES',

            // Fixes the name so that `Templates.get('foo/bar/baz')` resolves correctly.
            // Ex: /home/batman/atomic-lacuna/app/templates/menu/about
            // => 'menu/about'
            processName : function(location) {
                // Note: this will probably break on Windows. Sorry Windows users.
                var rv = location
                    // Remove everything that's templates/ and before.
                    .replace(/^\S+templates\//, '')

                    // Cull '.js' file extension
                    .replace(/\.js$/, '')

                    // Replace path separator with '.'
                    .split(path.sep).join('.');
                return rv;
            }
        }))
        .pipe(concat('templates.js'))
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('code-clean', function() {
    gulp.src(JS_FILES)
        .pipe(beautify({
            max_preserve_newlines : 3,
            brace_style : 'end-expand'
        }))
        .pipe(gulp.dest('app/js'));
});

gulp.task('download-shell', function() {
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
