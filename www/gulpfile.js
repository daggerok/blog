'use strict';

const srcDir = 'src/',
  mainJs = 'blog.js',
  mainCss = 'blog.css',
  anyJs = srcDir + '**/*.js',
  anyFonts = 'fonts/**/*.*',
  images = srcDir + 'img/**/*',
  htmlFiles = srcDir + '**/*.html',
  modulesDir = 'node_modules/',
  webDir = '../src/main/resources/public/';

const gulp = require('gulp'),
  combine = require('gulp-concat'),
  plumber = require('gulp-plumber'),
  connect = require('gulp-connect');

// clean build dir
gulp.task('clean', function() {
  return gulp
    .src([webDir], {read: false})
    .pipe(plumber())
    .pipe(require('gulp-rimraf')({force: true}));
});

// combine and min js files into build dir
gulp.task('js', function() {
  return gulp
    // emitting errors without plumber:
    //.on('error', console.error.bind(console))
    .src([
      modulesDir + 'jquery/dist/jquery.min.js',
      modulesDir + 'bootstrap/dist/js/bootstrap.min.js',
      modulesDir + 'angular/angular.min.js',
      modulesDir + 'angular-route/angular-route.min.js',
      modulesDir + 'angular-translate/dist/angular-translate.min.js',
      anyJs
    ])
    .pipe(plumber())
    .pipe(combine(mainJs))
    /**/
    .pipe(plumber())
    .pipe(require('gulp-uglify')())
    /**/
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// combine and min css files into build dir
gulp.task('css', function() {
  return gulp
    .src([
      modulesDir + 'font-awesome/css/font-awesome.min.css',
      modulesDir + 'bootstrap/dist/css/bootstrap.min.css',
      srcDir + mainCss
    ]).pipe(plumber())
    .pipe(require('gulp-autoprefixer')())
    .pipe(plumber())
    .pipe(combine(mainCss))
    /**/
    .pipe(plumber())
    .pipe(require('gulp-postcss')([require('csswring')({removeAllComments: true})]))
    /**/
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// min images into build dir
gulp.task('img', function() {
  return gulp
    .src(images, {base: srcDir})
    .pipe(plumber())
    .pipe(require('gulp-imagemin')())
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// copy fonts into build dir
gulp.task('fonts', function() {
  return gulp
    .src(modulesDir + 'font-awesome/' + anyFonts)
    .pipe(plumber())
    .pipe(gulp.dest(webDir + 'fonts/'))
    .pipe(connect.reload()); // livereoad 3
});

// replace and min html into build dir
gulp.task('html', function() {
  return gulp
    .src(htmlFiles, {base: srcDir})
    .pipe(plumber())
    .pipe(require('gulp-html-replace')({
      //'css': 'blog.css',
      //'js': 'blog.js'
      'css': '<link type="text/css" rel="stylesheet" href="blog.css"/>',
      'js': '<script type="text/javascript" src="blog.js"></script>'
    }))
    /**/
    .pipe(plumber())
    .pipe(require('gulp-minify-html')({
      quotes: true,
      conditionals: true,
      spare: true
    }))
    /**/
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

gulp.task('build', ['js', 'css', 'img', 'fonts', 'html']);

gulp.task('connect', function() { // livereoad 1
  return connect.server({
    root: webDir,
    livereload: true
  });
});

// run compiled sources
gulp.task('serve', require('gulp-serve')([webDir]));

// watch files into build
gulp.task('watch', ['build', 'connect'], function() { // livereoad 2
  gulp.watch(anyJs, ['js']);
  gulp.watch(srcDir + 'blog.css', ['css']);
  gulp.watch(images, ['img']);
  gulp.watch(htmlFiles, ['html']);
});

// run html task by default
gulp.task('default', ['build']);
