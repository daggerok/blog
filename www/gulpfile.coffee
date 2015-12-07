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
sourcemaps       = require 'gulp-sourcemaps'
{Server}         = require 'karma'

srcDir           = 'src/'
testDir          = 'test/'
mapsDir          = 'debug'
anyFiles         = '**/*.*'
mainJs           = 'blog.js'
jsFiles          = '**/*.js'
mainCss          = 'blog.css'
coffeeFiles      = '**/*.coffee'
modulesDir       = 'node_modules/'
anyTestJs        = "#{testDir}**/*.js"
anyFonts         = "fonts/#{anyFiles}"
htmls            = "#{srcDir}**/*.html"
images           = "#{srcDir}img/#{anyFiles}"
webDir           = '../src/main/resources/public/'
fontsDir         = "#{webDir}fonts/"
karmaJsConfig    = "#{__dirname}/#{testDir}karma.conf.js"
karmaCoffeConfig = "#{__dirname}/#{testDir}karma.conf.js"
fonts            = "#{modulesDir}font-awesome/#{anyFonts}"
genJsSrc         = srcDir + jsFiles
genJsTest        = testDir + jsFiles
javascripts      = [ "#{modulesDir}jquery/dist/jquery.js"
                     "#{modulesDir}bootstrap/dist/js/bootstrap.js"
                     "#{modulesDir}angular/angular.js"
                     "#{modulesDir}angular-route/angular-route.js"
                     "#{modulesDir}angular-translate/dist/angular-translate.js"
                     genJsSrc ]
stylesheets      = [ "#{modulesDir}font-awesome/css/font-awesome.css"
                     "#{modulesDir}bootstrap/dist/css/bootstrap.css"
                     srcDir + mainCss ]
genJs            = [ genJsSrc
                     genJsTest ]

# clean build dir
gulp.task 'clean', ->
  gulp.src webDir, read: false
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
    #.pipe sourcemaps.init()
    .pipe concat mainJs
    .pipe uglify()
    #.pipe sourcemaps.write mapsDir
    .pipe gulp.dest webDir

# combine and min css files into build dir
gulp.task 'css', ->
  gulp.src stylesheets
    #.pipe sourcemaps.init()
    .pipe prefixer browsers: ['last 2 versions']
    .pipe concat mainCss
    .pipe minifycss compatibility: 'ie8'
    #.pipe sourcemaps.write mapsDir
    .pipe gulp.dest webDir

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
    .pipe gulp.dest fontsDir
    .pipe connect.reload()

# replace and min html into build dir
gulp.task 'html', ->
  gulp.src htmls, base: srcDir
    .pipe replace
      'css': '<link rel="stylesheet" href="blog.css">'
      'js': '<script src="blog.js"></script>'
    .pipe minifyhtml
      conditionals: true
      quotes: true
      spare: true
    .pipe gulp.dest webDir

gulp.task 'build', [
  'coffee-src'
  'fonts'
  'html'
  'img'
  'css'
  'js'
]

# run html task by default
gulp.task 'default', ['build']

# run compiled sources
gulp.task 'serve', serve [webDir]

gulp.task 'dev-js', ->
  gulp.src javascripts
    .pipe gulp.dest webDir
    .pipe connect.reload()

gulp.task 'dev-css', ->
  gulp.src stylesheets
    .pipe gulp.dest webDir
    .pipe connect.reload()

gulp.task 'dev-html', ->
  gulp.src htmls, base: srcDir
    .pipe gulp.dest webDir
    .pipe connect.reload()

gulp.task 'dev', [
  'coffee-src'
  'fonts'
  'img'
  'dev-html'
  'dev-css'
  'dev-js'
]

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

gulp.task 'connect', ->
  connect.server
    root: webDir
    livereload: true

# watch files into build
gulp.task 'watch', [
  'connect'
  'dev'
], ->
  gulp.watch stylesheets, ['dev-css']
  gulp.watch htmls, ['dev-html']
  gulp.watch fontsDir, ['fonts']
  gulp.watch images, ['img']
  gulp.watch srcDir + coffeeFiles, [
    'test-coffee'
    'coffee-src'
    'dev-js'
  ]
  gulp.watch testDir + coffeeFiles, [
    'test-coffee'
    'coffee-test'
    'dev-js'
  ]
  gulp.watch [
    webDir
    genJsSrc
    genJsTest
  ], ['test-js']
