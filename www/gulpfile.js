'use strict';

const srcDir = 'src/',
  anyJs = '**/*.js',
  anyCss = '**/*.css',
  mainJs = 'js/blog.js',
  mainCss = 'css/blog.css',
  images = srcDir + 'img/**/*',
  htmlFiles = srcDir + '**/*.html',
  modulesDir = 'node_modules/',
  webDir = '../src/main/resources/public/';

const gulp = require('gulp'),
  clean = require('gulp-rimraf'),
  combine = require('gulp-concat'),
  plumber = require('gulp-plumber'),
  postcss = require('gulp-postcss'),
  webserver = require('gulp-webserver'),
  replace = require('gulp-html-replace'),
  autoprefixer = require('gulp-autoprefixer'),
  minifyHTML = require('gulp-minify-html'),
  minifyImg = require('gulp-imagemin'),
  minifyJs = require('gulp-uglify'),
  minifyCss = require('csswring');

// run development web server
gulp.task('server', function() {
  gulp.src('.')
    .pipe(webserver({
      port: 3000,
      livereload: {
        enable: true
      }}));
});

// watch files into build 
gulp.task('watch', ['default'], function() {
  gulp.watch(srcDir + anyJs, ['scripts']);
  gulp.watch(srcDir + anyCss, ['styles']);
  gulp.watch(images, ['images']);
  gulp.watch(htmlFiles, ['htmls']);
  // also start live reload
  gulp.start('server');
});

// clean build dir
gulp.task('clean', function() {
  gulp
    .src(webDir, {read: false})
    .pipe(plumber())
    .pipe(clean({force: true}));
});

// combine and min js files into build dir
gulp.task('scripts', function() {
  const scripts = [
    modulesDir + 'angular/angular.js',
    srcDir + mainJs
  ];

  gulp
    .src(scripts)
    .pipe(plumber())
    .pipe(combine(mainJs))
    .pipe(plumber())
    .pipe(minifyJs())
    // emitting errors without plumber:
    //.on('error', console.error.bind(console))
    .pipe(gulp.dest(webDir));
});

// combine and min css files into build dir
gulp.task('styles', function() {
  const styles = [
    modulesDir + 'bootstrap/dist/css/bootstrap.css',
    srcDir + mainCss
  ];

  gulp
    .src(styles)
    .pipe(plumber())
    .pipe(autoprefixer())
    .pipe(plumber())
    .pipe(combine(mainCss))
    .pipe(plumber())
    .pipe(postcss([minifyCss({removeAllComments: true})]))
    .pipe(gulp.dest(webDir));
});

// min images into build dir
gulp.task('images', function() {
  gulp
    .src(images, {base: srcDir})
    .pipe(plumber())
    .pipe(minifyImg())
    .pipe(gulp.dest(webDir));
});

// replace and min html into build dir
gulp.task('htmls', function() {
  gulp
    .src(htmlFiles, {base: srcDir})
    .pipe(plumber())
    .pipe(replace({
      'css': 'css/blog.css',
      'js': 'js/blog.js'
    }))
    .pipe(plumber())
    .pipe(minifyHTML({
      quotes: true,
      conditionals: true,
      spare:true
    }))
    .pipe(gulp.dest(webDir));
});

gulp.task('deploy', ['scripts', 'styles', 'images', 'htmls']);

// run html task by default
gulp.task('default', ['deploy']);
