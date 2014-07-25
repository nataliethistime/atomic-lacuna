var gulp       = require('gulp');

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
var through = require('through');
var coffee = require('coffee-script');
coffee.register();
var source = require('vinyl-source-stream');
var AtomShellDownload = require('atom-shell-pull');
var _ = require('lodash');

var path = require('path');

var JS_FILES = ['app/js/**/*.js'];
var packageJson = require(path.join(__dirname, 'package.json'));

gulp.task('lint', function() {
    gulp.src(JS_FILES)
        // Note: the following options need to be enabled sometime later:
        // ~> es3 : true
        // ~> quotmark : 'single'
        // ~> unused : true
        // ~> eqeqeq : true
        // ~> shadow : false
        // ~> loopfunc : true
        // ~> forin : true

        // Note JSHint finds configuration options in the .jshintrc
        .pipe(jshint())
        .pipe(jshint.reporter(stylish))
        .pipe(jshint.reporter('fail'));
});

gulp.task('code-build', function() {
    process.env.NODE_PATH = path.join(__dirname, 'app')

    var b = browserify(['./app/js/main.js'], {
        insertGlobals : true,
        ignoreMissing : true, // Ignore missing modules. (Ex: 'ipc', 'remote').
        extensions: ['.coffee']
    });

    // Compile CoffeeScript code.
    b.transform(function (file) {
        var data = '';

        function write(buf) {
            data += buf
        }

        // Ignore JS code.
        if (file.match(/\.coffee$/)) {
            return through(write, function() {
                this.queue(coffee.compile(data));
                this.queue(null);
            });
        }
        else {
            return through(write, function() {
                this.queue(data);
                this.queue(null);
            });
        }
    });

    b
        .bundle()
        // Rename to 'browser-build.js'
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
            // => 'menu.about'
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
