'use strict';

var srcDir = 'src/',
  anyCss = '**/*.css',
  cssDir = srcDir + 'css/',
  jsFiles = srcDir + '**/*.js',
  images = srcDir + 'img/**/*',
  htmlFiles = srcDir + '**/*.html',
  webDir = '../src/main/resources/public/';

var gulp = require('gulp'),
  clean = require('gulp-rimraf'),
  plumber = require('gulp-plumber'),
  postcss = require('gulp-postcss'),
  replace = require('gulp-html-replace'),
  combineCss = require('gulp-concat'),
  minifyImg = require('gulp-imagemin'),
  minifyJs = require('gulp-uglify'),
  minifyCss = require('csswring');

// watch files into build 
gulp.task('watch', ['default'], function() {
  gulp.watch(jsFiles, ['min-js']);
  gulp.watch(srcDir + anyCss, ['min-css']);
  gulp.watch(images, ['min-img']);
  gulp.watch(htmlFiles, ['html']);
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
    .src(jsFiles)
    .pipe(plumber())
    .pipe(minifyJs())
    // emitting errors without plumber:
    //.on('error', console.error.bind(console))
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
    .pipe(plumber())
    .pipe(combineCss('css/blog.css'))
    .pipe(plumber())
    .pipe(postcss([minifyCss]))
    .pipe(gulp.dest(webDir));
});

// minify images into build dir
gulp.task('min-img', function() {
  gulp
    .src(images, {base: srcDir})
    .pipe(minifyImg())
    .pipe(gulp.dest(webDir));
});

// minify sources
gulp.task('min', ['min-js', 'min-css', 'min-img']);

// replace html into build dir
gulp.task('html', function() {
  gulp
    .src(htmlFiles, {base: srcDir})
    .pipe(plumber())
    .pipe(replace({
      'css': 'css/blog.css',
      'js': 'js/blog.js'
    }))
    .pipe(gulp.dest(webDir));
});

// run html task by default
gulp.task('default', ['libs', 'min', 'html']);
