'use strict';

var srcDir = 'src/',
  cssDir = srcDir + 'css/',
  webDir = '../src/main/resources/public/';

var gulp = require('gulp'),
  watch = require('gulp-watch'),
  batch = require('gulp-batch'),
  clean = require('gulp-rimraf'),
  postcss = require('gulp-postcss'),
  replace = require('gulp-html-replace'),
  combineCss = require('gulp-concat'),
  minifyJs = require('gulp-uglify'),
  minifyCss = require('csswring');


/* WATCH */

// watch js files into build dir
gulp.task('watch-js', function() {
  watch(srcDir + '**/*.js', batch(function(events, done) {
    gulp.start('min-js', done);
  }));
});

// watch css files into build dir
gulp.task('watch-css', function() {
  watch(srcDir + '**/*.css', batch(function(events, done) {
    gulp.start('min-css', done);
  }));
});

// watch images into build dir
gulp.task('watch-img', function() {
  watch(srcDir + '**/*.html', batch(function(events, done) {
    gulp.start('img', done);
  }));
});

// watch html files into build dir
gulp.task('watch-html', function() {
  watch(srcDir + '**/*.html', batch(function(events, done) {
    gulp.start('html', done);
  }));
});

/* BUILD */

// clean build dir
gulp.task('clean', function() {
  return gulp
    .src(webDir, {read: false})
    .pipe(clean({force: true}));
});

// copy vendor libs into build dir
gulp.task('libs', function() {
  gulp
    .src('node_modules/normalize.css/normalize.css')
    .pipe(gulp.dest(cssDir));
});

// combine and minify js files into build dir
gulp.task('min-js', function() {
  gulp
    .src(srcDir + '**/*.js')
    .pipe(minifyJs())
    .pipe(gulp.dest(webDir));
});

// combine and minify css files into build dir
gulp.task('min-css', function() {
  var styles = [
    cssDir + 'normalize.css',
    cssDir + 'blog.css'
  ];

  gulp
    .src(styles)
    .pipe(combineCss('css/blog.css'))
    .pipe(postcss([minifyCss]))
    .pipe(gulp.dest(webDir));
});

// minify images into build dir
gulp.task('img', function() {
  gulp
    .src(srcDir + 'img/*.*', {base: srcDir})
    .pipe(gulp.dest(webDir));
});

// replace html into build dir
gulp.task('html', ['min-js', 'min-css', 'img'], function() {
  gulp
    .src(srcDir + '**/*.html', {base: srcDir})
    .pipe(replace({
      'css': 'css/blog.css',
      'js': 'js/blog.js'
    }))
    .pipe(gulp.dest(webDir));
});

// run html task by default
gulp.task('default', ['clean', 'libs', 'min-js', 'min-css', 'img', 'html']);
