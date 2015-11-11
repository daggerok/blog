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
  rm = require('gulp-rimraf'),
  combine = require('gulp-concat'),
  plumber = require('gulp-plumber'),
  connect = require('gulp-connect'),
  compress = require('gulp-gzip'),
  rename = require("gulp-rename");

gulp.task('connect', function() { // livereoad 1
  connect.server({
    root: webDir,
    livereload: true
  });
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
    .pipe(rm({force: true}));
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
  // zip all to mainJs
  return gulp
    .src(scripts)
    .pipe(plumber())
    .pipe(combine(mainJs))
    .pipe(plumber())
    .pipe(require('gulp-uglify')())
    // emitting errors without plumber:
    //.on('error', console.error.bind(console))
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload()); // livereoad 3
});

// vendors to libs/css
gulp.task('css-vendor', function() {
  return gulp.src([
    modulesDir + 'font-awesome/css/font-awesome.css',
    modulesDir + 'bootstrap/dist/css/bootstrap.css'
  ]).pipe(gulp.dest(libs + 'css/'))});
// combine and min css files into build dir ?? ????????????
gulp.task('uncompressed-styles', ['css-vendor'], function() {
  var styles = [
    libs + 'css/font-awesome.css',
    libs + 'css/bootstrap.css',
    srcDir + mainCss
  ];
  // zip all to mainCss
  return gulp
    .src(styles)
    .pipe(plumber())
    .pipe(require('gulp-autoprefixer')())
    .pipe(plumber())
    .pipe(combine(mainCss))
    .pipe(plumber())
    .pipe(require('gulp-postcss')([require('csswring')({removeAllComments: true})]))
    .pipe(gulp.dest(webDir))
    .pipe(connect.reload())}); // livereoad 3
//rename according requirements
gulp.task('rename-nogzip-styles', ['uncompressed-styles'], function() {
  return gulp.src(webDir + mainCss)
    .pipe(plumber())
    .pipe(rename('blog.nogzip.css'))
    .pipe(gulp.dest(webDir + 'css/'))});
// compress full styles file
gulp.task('compress-styles', ['rename-nogzip-styles'], function() {
  return gulp.src(webDir + 'css/blog.nogzip.css')
    .pipe(plumber())
    .pipe(compress({
      append: true,
      extension: 'gz',
      threshold: true,
      gzipOptions: {
        level: 9,
        memLevel: 5
      }}))
    .pipe(gulp.dest(webDir + 'css/'))});
// rename compressed file according requirements
gulp.task('commpressed-to-styles', ['compress-styles'], function() {
  return gulp.src(webDir + 'css/blog.nogzip.css.gz')
    .pipe(plumber())
    .pipe(rename(mainCss))
    .pipe(gulp.dest(webDir))});
// remove temp style file
gulp.task('styles', ['commpressed-to-styles'], function() {
  return gulp.src(webDir + 'css/blog.nogzip.css.gz')
    .pipe(rm({force: true}))});

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
