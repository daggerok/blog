'use strict';

const srcDir = 'src/',
  libs = srcDir + 'libs/',
  mainJs = 'js/blog.js',
  mainCss = 'css/blog.css',
  anyFonts = 'fonts/**/*.*',
  images = srcDir + 'img/**/*',
  htmlFiles = srcDir + '**/*.html',
  modulesDir = 'node_modules/',
  webDir = '../src/main/resources/public/';

const gulp = require('gulp'),
  combine = require('gulp-concat'),
  plumber = require('gulp-plumber'),
  connect = require('gulp-connect');

gulp.task('connect', function() { // livereoad 1
  connect.server({
    root: webDir,
    livereload: true});
});

// run compiled sources
gulp.task('serve', require('gulp-serve')([webDir]));

// watch files into build
gulp.task('watch', ['deploy', 'connect'], function() { // livereoad 2
  gulp.watch(srcDir + 'js/**/*.js', ['scripts']);
  gulp.watch(srcDir + 'css/**/*.css', ['styles']);
  gulp.watch(images, ['images']);
  gulp.watch(htmlFiles, ['htmls']);
});

// clean build dir
gulp.task('clean', function() {
  return gulp
    .src([webDir], {read: false})
    .pipe(plumber())
    .pipe(require('gulp-rimraf')({force: true}));
});

// vendors to libs/js
gulp.task('js-vendor', function() {
  return gulp.src([
    modulesDir + 'jquery/dist/jquery.js',
    modulesDir + 'bootstrap/dist/js/bootstrap.js',
    modulesDir + 'angular/angular.js'
  ]).pipe(gulp.dest(libs + 'js/'));
});

// combine and min js files into build dir
gulp.task('scripts', ['js-vendor'], function() {
  var scripts = [
    libs + 'js/jquery.js',
    libs + 'js/bootstrap.js',
    libs + 'js/angular.js',
    srcDir + mainJs,
    srcDir + 'js/directives.js'
  ];
  // combine and min all to mainJs
  return gulp
    // emitting errors without plumber:
    //.on('error', console.error.bind(console))
    .src(scripts)
    .pipe(plumber())
    .pipe(combine(mainJs))
    .pipe(plumber())
    .pipe(require('gulp-uglify')())
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// vendors to libs/css
gulp.task('css-vendor', function() {
  return gulp.src([
    modulesDir + 'font-awesome/css/font-awesome.css',
    modulesDir + 'bootstrap/dist/css/bootstrap.css'
  ]).pipe(gulp.dest(libs + 'css/'));
});

// combine and min css files into build dir
gulp.task('styles', ['css-vendor'], function() {
  var styles = [
    libs + 'css/font-awesome.css',
    libs + 'css/bootstrap.css',
    srcDir + mainCss
  ];
  // zip all to mainCss
  return gulp
    .src(styles).pipe(plumber())
    .pipe(require('gulp-autoprefixer')())
    .pipe(plumber())
    .pipe(combine(mainCss))
    .pipe(plumber())
    .pipe(require('gulp-postcss')([require('csswring')({removeAllComments: true})]))
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// min images into build dir
gulp.task('images', function() {
  return gulp
    .src(images, {base: srcDir})
    .pipe(plumber())
    .pipe(require('gulp-imagemin')())
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// fonts vendor
gulp.task('fonts-vendor', function() {
  return gulp
    .src(modulesDir + 'font-awesome/' + anyFonts)
    .pipe(gulp.dest(srcDir + 'fonts/'));
});

// copy fonts into build dir
gulp.task('fonts', ['fonts-vendor'], function() {
  return gulp
    .src(srcDir + anyFonts, {base: srcDir})
    .pipe(plumber())
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// replace and min html into build dir
gulp.task('htmls', ['styles', 'scripts'], function() {
  return gulp
    .src(htmlFiles, {base: srcDir})
    .pipe(plumber())
    .pipe(require('gulp-html-replace')({
      'css': 'css/blog.css',
      'js': 'js/blog.js'
    }))
    .pipe(plumber())
    .pipe(require('gulp-minify-html')({
      quotes: true,
      conditionals: true,
      spare:true
    }))
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

gulp.task('deploy', ['images', 'fonts', 'htmls']);

// run html task by default
gulp.task('default', ['deploy']);
