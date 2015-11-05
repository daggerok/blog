'use strict'

var fromDir = 'src-ui/'
var toDir = 'src/main/resources/public'
var gulp = require('gulp'),
    rm = require('rimraf'),
    postcss = require('gulp-postcss'),
    sourcemaps = require('gulp-sourcemaps');

gulp.task('clean', function(cb) {
  console.log('clean '.concat(toDir).concat(' folder'));
  rm(toDir, cb)
});

gulp.task('build', ['clean'], function() {
  console.log('process '.concat(fromDir).concat(' folder'));
});

gulp.task('deploy', ['build'], function() {
  console.log('deploy ui into '.concat(toDir));

  gulp.src([
    fromDir.concat('**/*.js'),
  ], {
    base: fromDir
  }).pipe(gulp.dest(toDir));

  gulp.src([
    fromDir.concat('**/*.css'),
  ], {
    base: fromDir
  }).pipe(gulp.dest(toDir));

  gulp.src([
    fromDir.concat('**/*.html'),
  ], {
    base: fromDir
  }).pipe(gulp.dest(toDir));
});

gulp.task('default', ['deploy']);
