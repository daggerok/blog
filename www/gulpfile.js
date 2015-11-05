'use strict';

var srcDir = 'src/',
  cssDir = srcDir + 'css/',
  webDir = '../src/main/resources/public/';

var gulp = require('gulp'),
  clean = require('gulp-rimraf'),
  postcss = require('gulp-postcss'),
  replace = require('gulp-html-replace'),
  combineCss = require('gulp-concat'),
  minifyJs = require('gulp-uglify'),
  minifyCss = require('csswring');

gulp.task('clean', function() {
  console.log('clean ' + webDir);
  return gulp
    .src(webDir, {read: false})
    .pipe(clean({force: true}));
});

gulp.task('libs', ['clean'], function() {
  gulp
    .src('node_modules/normalize.css/normalize.css')
    .pipe(gulp.dest(cssDir));
});

gulp.task('min-js', ['libs'], function() {
  console.log('compile js');
  gulp
    .src(srcDir + '**/*.js')
    .pipe(minifyJs())
    .pipe(gulp.dest(webDir));
});

gulp.task('min-css', ['libs'], function() {
  var styles = [
    cssDir + 'normalize.css',
    cssDir + 'blog.css'
  ];

  console.log('compile css');
  gulp
    .src(styles)
    .pipe(combineCss('css/blog.css'))
    .pipe(postcss([minifyCss]))
    .pipe(gulp.dest(webDir));
});

gulp.task('img', ['libs'], function() {
  console.log('compile images');
  gulp
    .src(srcDir + 'img/*.*', {base: srcDir})
    .pipe(gulp.dest(webDir));
});

gulp.task('html', ['min-js', 'min-css', 'img'], function() {
  console.log('compile html');
  gulp
    .src(srcDir + '**/*.html', {base: srcDir})
    .pipe(replace({
      'css': 'css/blog.css',
      'js': 'js/blog.js'
    }))
    .pipe(gulp.dest(webDir));
});

gulp.task('default', ['html']);
