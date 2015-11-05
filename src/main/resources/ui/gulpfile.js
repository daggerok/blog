var gulp = require('gulp'),
    rm = require('rimraf');

var fromDir = 'app/'
var toDir = '../public/'

gulp.task('clean', function(cb) {
  console.log('clean ../public folder');
  return rm(toDir, cb)
});

gulp.task('build', ['clean'], function() {
  return console.log('process ui sources');
});

gulp.task('deploy', ['build'], function() {
  console.log('deploy ui project into ../public folder');

  return gulp.src([
    fromDir.concat('**/*.html'),
  ], {
    base: fromDir
  }).pipe(gulp.dest(toDir));
});

gulp.task('default', ['deploy']);
