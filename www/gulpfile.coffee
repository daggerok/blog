'use strict'

gulp             = require 'gulp'
serve            = require 'gulp-serve'
remove           = require 'gulp-rimraf'
plumber          = require 'gulp-plumber'
coffee           = require 'gulp-coffee'
concat           = require 'gulp-concat'
uglify           = require 'gulp-uglify'
connect          = require 'gulp-connect'
prefixer         = require 'gulp-autoprefixer'
minifycss        = require 'gulp-minify-css'
imagemin         = require 'gulp-imagemin'
minifyhtml       = require 'gulp-minify-html'
replace          = require 'gulp-html-replace'
srcmaps          = require 'gulp-sourcemaps'
{Server}         = require 'karma'

srcDir           = 'src/'
testDir          = 'test/'
mapsDir          = 'debug'
mainJs           = 'blog.js'
jsFiles          = '**/*.js'
mainCss          = 'blog.css'
coffeeFiles      = '**/*.coffee'
anyFiles         = '**/*.*'
anyFonts         = "fonts/#{anyFiles}"
modulesDir       = 'node_modules/'
anyTestJs        = "#{testDir}**/*.js"
images           = "#{srcDir}img/#{anyFiles}"
htmls            = "#{srcDir}**/*.html"
webDir           = '../src/main/resources/public/'
karmaJsConfig    = "#{__dirname}/#{testDir}karma.conf.js"
karmaCoffeConfig = "#{__dirname}/#{testDir}karma.conf.js"
genJsSrc         = srcDir + jsFiles
javascripts      = [ "#{modulesDir}jquery/dist/jquery.js"
                     "#{modulesDir}bootstrap/dist/js/bootstrap.js"
                     "#{modulesDir}angular/angular.js"
                     "#{modulesDir}angular-route/angular-route.js"
                     "#{modulesDir}angular-translate/dist/angular-translate.js"
                     genJsSrc ]
stylesheets      = [ "#{modulesDir}font-awesome/css/font-awesome.css"
                     "#{modulesDir}bootstrap/dist/css/bootstrap.css"
                     srcDir + mainCss ]
fonts            = "#{modulesDir}font-awesome/#{anyFonts}"
fontsDir         = "#{webDir}fonts/"
genJsTest        = testDir + jsFiles
genJs            = [ genJsSrc
                     genJsTest ]

# clean build dir
gulp.task 'clean', ->
  gulp.src [webDir], read: false
    .pipe remove force: true

# clean generated src js
gulp.task 'clean-gen-src', ->
  gulp.src genJsSrc, read: false
    .pipe remove force: true

# clean generated test js
gulp.task 'clean-gen-test', ->
  gulp.src genJsTest, read: false
    .pipe remove force: true

# clean generated js
gulp.task 'clean-gen', [
  'clean-gen-js-src'
  'clean-gen-js-test'
]

compile = (srcDir) ->
  gulp.src srcDir + coffeeFiles
    .pipe plumber()
    .pipe coffee bare: true
    #  .on 'error', -> console?.log error
    .pipe gulp.dest srcDir

gulp.task 'coffee-src', ->
  compile srcDir

gulp.task 'coffee-test', ->
  compile testDir

gulp.task 'coffee', [
  'coffee-src'
  'coffee-test'
]

# combine and min js files into build dir
gulp.task 'js', ->
  gulp.src javascripts
    .pipe srcmaps.init()
    .pipe plumber()
    .pipe concat mainJs
    .pipe plumber()
    .pipe uglify()
    .pipe srcmaps.write mapsDir
    .pipe gulp.dest webDir
    .pipe connect.reload()

# combine and min css files into build dir
gulp.task 'css', ->
  gulp.src stylesheets
    .pipe srcmaps.init()
    .pipe plumber()
    .pipe prefixer browsers: ['last 2 versions']
    .pipe plumber()
    .pipe concat mainCss
    .pipe plumber()
    .pipe minifycss compatibility: 'ie8'
    .pipe srcmaps.write mapsDir
    .pipe gulp.dest webDir
    .pipe connect.reload()

# min images into build dir
gulp.task 'img', ->
  gulp.src images, base: srcDir
    .pipe plumber()
    .pipe imagemin()
    .pipe gulp.dest webDir
    .pipe connect.reload()

# copy fonts into build dir
gulp.task 'fonts', ->
  gulp.src fonts
    .pipe plumber()
    .pipe gulp.dest fontsDir
    .pipe connect.reload()

# replace and min html into build dir
gulp.task 'html', ->
  gulp.src htmls, base: srcDir
    .pipe plumber()
    .pipe replace
      'css': '<link rel="stylesheet" href="blog.css">'
      'js': '<script src="blog.js"></script>'
    .pipe plumber()
    .pipe minifyhtml
      conditionals: true
      quotes: true
      spare: true
    .pipe gulp.dest webDir
    .pipe connect.reload()

gulp.task 'build', [
  'coffee-src'
  'css'
  'img'
  'fonts'
  'html'
  'js'
]

gulp.task 'connect', ->
  connect.server
    root: webDir
    livereload: true

# run compiled sources
gulp.task 'serve', serve [webDir]

gulp.task 'test-js', (done) ->
  new Server(
      configFile: karmaJsConfig
      singleRun: true,
    done)
  .start()

gulp.task 'test-coffee', (done) ->
  new Server(
    configFile: karmaCoffeConfig
    singleRun: true,
    done)
  .start()

gulp.task 'test', [
  'test-coffee'
  'test-js'
]

# watch files into build
gulp.task 'watch', [
  'build'
  'connect'
], ->
  gulp.watch srcDir + mainCss, ['css']
  gulp.watch htmls, ['html']
  gulp.watch images, ['img']
  gulp.watch genJsSrc, ['js']
  gulp.watch srcDir + coffeeFiles, [
    'test-coffee'
    'coffee-src'
  ]
  gulp.watch testDir + coffeeFiles, [
    'test-coffee'
    'coffee-test'
  ]
  gulp.watch [
    webDir
    genJsTest
  ], ['test-js']

# run html task by default
gulp.task 'default', ['build']
