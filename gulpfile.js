'use strict';

var from = 'src-ui/',
  cssSrc = from + 'css/',
  dest = 'src/main/resources/public/';

var gulp = require('gulp'),
  uglify = require('gulp-uglify'),
  concat = require('gulp-concat'),
  postcss = require('gulp-postcss'),
  htmlReplace = require('gulp-html-replace'),
  csswring = require('csswring'),
  del = require('del');

gulp.task('clean', function() {
  console.log('clean ' + dest);
  del(dest);
});

gulp.task('libs', ['clean'], function() {
  gulp
    .src('node_modules/'.concat('/normalize.css/normalize.css'))
    .pipe(gulp.dest(cssSrc));
});

gulp.task('min-js', ['libs'], function() {
  console.log('process js files into ' + dest);
  gulp
    .src(from + '**/*.js')
    .pipe(uglify())
    .pipe(gulp.dest(dest));
});

gulp.task('css', ['libs'], function() {
  var styles = [
    cssSrc.concat('normalize.css'),
    cssSrc.concat('blog.css')
  ];
  var processors = [csswring];

  console.log('process ' + styles + ' into ' + dest);
  gulp
    .src(styles)
    .pipe(concat('css/blog.css'))
    .pipe(postcss(processors))
    .pipe(gulp.dest(dest));
});

gulp.task('html', ['min-js', 'css'], function() {
  console.log('process html files into ' + dest);
  gulp
    .src(from.concat('**/*.html'), {base: from})
    .pipe(htmlReplace({
      'css': 'css/blog.css',
      'js': 'js/blog.js'
    }))
    .pipe(gulp.dest(dest));
});

gulp.task('default', ['html']);
