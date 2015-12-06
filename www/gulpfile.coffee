"use strict"

gulp         = require "gulp"
serve        = require "gulp-serve"
remove       = require "gulp-rimraf"
coffee       = require "gulp-coffee"
combine      = require "gulp-concat"
uglify       = require "gulp-uglify"
connect      = require "gulp-connect"
postcss      = require "gulp-postcss"
minifycss    = require "csswring"
plumber      = require "gulp-plumber"
imagemin     = require "gulp-imagemin"
minifyhtml   = require "gulp-minify-html"
autoprefixer = require "gulp-autoprefixer"
srcmaps      = require 'gulp-sourcemaps'
{Server}     = require 'karma'

srcDir       = "src/"
testDir      = "test/"
mainJs       = "blog.js"
jsFiles      = "**/*.js"
mainCss      = "blog.css"
coffeeFiles  = "**/*.coffee"
anyFonts     = "fonts/**/*.*"
modulesDir   = "node_modules/"
anyTestJs    = "#{testDir}**/*.js"
images       = "#{srcDir}img/**/*"
htmls        = "#{srcDir}**/*.html"
webDir       = "../src/main/resources/public/"
karmaConfig  = "#{__dirname}/#{testDir}karma.conf.js"
genJsSrc     = srcDir + jsFiles
genJsTest    = testDir + jsFiles
genJs        = [ genJsSrc
                 genJsTest ]

# clean build dir
gulp.task "clean", ->
  gulp.src [webDir], read: false
    .pipe remove force: true

# clean generated src js
gulp.task "clean-gen-js-src", ->
  gulp.src genJsSrc, read: false
    .pipe remove force: true

# clean generated test js
gulp.task "clean-gen-js-test", ->
  gulp.src genJsTest, read: false
    .pipe remove force: true

# clean generated js
gulp.task "clean-gen-js", [
  "clean-gen-js-src"
  "clean-gen-js-test"
]

compile = (srcDir) ->
  gulp.src srcDir + coffeeFiles
    .pipe plumber()
    .pipe coffee bare: true
    #  .on "error", -> console?.log error
    .pipe gulp.dest srcDir

gulp.task "coffee-src", ->
  compile srcDir

gulp.task "coffee-test", ->
  compile testDir

gulp.task "coffee", ["coffee-src", "coffee-test"]

# combine and min js files into build dir
gulp.task "js", ->
  gulp.src [
      "#{modulesDir}jquery/dist/jquery.min.js"
      "#{modulesDir}bootstrap/dist/js/bootstrap.min.js"
      "#{modulesDir}angular/angular.min.js"
      "#{modulesDir}angular-route/angular-route.min.js"
      "#{modulesDir}angular-translate/dist/angular-translate.min.js"
      genJsSrc
    ]
    .pipe plumber()
    .pipe combine mainJs
    .pipe plumber()
    .pipe uglify()
    .pipe gulp.dest webDir
    .pipe connect.reload()

# combine and min css files into build dir
gulp.task "css", ->
  gulp.src [
      "#{modulesDir}font-awesome/css/font-awesome.min.css"
      "#{modulesDir}bootstrap/dist/css/bootstrap.min.css"
      srcDir + mainCss
    ]
    .pipe plumber()
    .pipe autoprefixer()
    .pipe plumber()
    .pipe combine mainCss
    .pipe plumber()
    .pipe postcss [
      minifycss removeAllComments: true
    ]
    .pipe gulp.dest webDir
    .pipe connect.reload()

# min images into build dir
gulp.task "img", ->
  gulp.src images, base: srcDir
    .pipe plumber()
    .pipe imagemin()
    .pipe gulp.dest webDir
    .pipe connect.reload()

# copy fonts into build dir
gulp.task "fonts", ->
  gulp.src "#{modulesDir}font-awesome/#{anyFonts}"
    .pipe plumber()
    .pipe gulp.dest "#{webDir}fonts/"
    .pipe connect.reload()

# replace and min html into build dir
gulp.task "html", ->
  gulp.src htmls, base: srcDir
    .pipe plumber()
    .pipe require("gulp-html-replace")
      "css": """<link type="text/css" rel="stylesheet" href="blog.css"/>"""
      "js": """<script type="text/javascript" src="blog.js"></script>"""
    .pipe plumber()
    .pipe minifyhtml
      conditionals: true
      quotes: true
      spare: true
    .pipe gulp.dest webDir
    .pipe connect.reload()

gulp.task "build", [
  "coffee-src"
  "css"
  "img"
  "fonts"
  "html"
  "js"
]

gulp.task "connect", ->
  connect.server
    root: webDir
    livereload: true

# run compiled sources
gulp.task "serve", serve [webDir]

gulp.task 'test', (done) ->
  new Server(
      configFile: karmaConfig
      singleRun: true,
    done)
  .start()

# watch files into build
gulp.task "watch", ["build", "connect"], ->
  gulp.watch "#{srcDir}blog.css", ["css"]
  gulp.watch htmls, ["html"]
  gulp.watch images, ["img"]
  gulp.watch genJsSrc, ["js"]
  gulp.watch srcDir + coffeeFiles, ["coffee-src"]
  gulp.watch testDir + coffeeFiles, ["coffee-test"]
  gulp.watch [
    webDir
    testDir
  ], ["test"]

# run html task by default
gulp.task "default", ["build"]
