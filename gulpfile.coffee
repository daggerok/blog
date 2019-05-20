"use strict"

newVer          =   new Date().toISOString().replace(/\..+$|[^\d]/g, "").substr 0, 12 # Date.now()
cssVer          =   undefined ? newVer # <-- ?v=yyyymmddhhMM
jsVer           =   undefined ? newVer # to specify static replace undefined
srcDir          =   "src/main/www/src/"
testDir         =   "src/main/www/test/"
mapsDir         =   "debug"
anyFiles        =   "**/*.*"
mainJs          =   "blog.js"
jsFiles         =   "**/*.js"
mainCss         =   "blog.css"
coffeeFiles     =   "**/*.coffee"
modulesDir      =   "node_modules/"
anyTestJs       =   "#{testDir}**/*.js"
anyFonts        =   "fonts/#{anyFiles}"
htmls           =   "#{srcDir}**/*.html"
images          =   "#{srcDir}img/#{anyFiles}"
webDir          =   "src/main/resources/public/"
webapp          =   "src/main/webapp/"
fonts           =   "fonts/"
fontsDir        =   webDir + fonts
karmaJsConf     =   "#{__dirname}/#{testDir}karma.conf.js"
karmaCoffeeConf =   "#{__dirname}/#{testDir}karma-coffee.conf.coffee"
fontAwesome     =   "#{modulesDir}font-awesome/#{anyFonts}"
genJsSrc        =   srcDir + jsFiles
genJsTest       =   testDir + jsFiles
javascripts     = [ "#{modulesDir}jquery/dist/jquery.js"
                    "#{modulesDir}bootstrap/dist/js/bootstrap.js"
                    "#{modulesDir}angular/angular.js"
                    "#{modulesDir}angular-route/angular-route.js"
                    "#{modulesDir}angular-translate/dist/angular-translate.js"
                    srcDir + jsFiles ]
stylesheets     = [ "#{modulesDir}font-awesome/css/font-awesome.css"
                    "#{modulesDir}bootstrap/dist/css/bootstrap.css"
                    srcDir + mainCss ]
genJs           = [ genJsSrc
                    genJsTest ]
gulp            =   require "gulp"
serve           =   require "gulp-serve"
remove          =   require "gulp-rimraf"
coffee          =   require "gulp-coffee"
concat          =   require "gulp-concat"
uglify          =   require "gulp-uglify"
connect         =   require "gulp-connect"
prefixer        =   require "gulp-autoprefixer"
minifycss       =   require "gulp-minify-css"
imagemin        =   require "gulp-imagemin"
minifyhtml      =   require "gulp-minify-html"
replace         =   require "gulp-html-replace"
sourcemaps      =   require "gulp-sourcemaps"
{Server}        =   require "karma"

require "colors"
log = (error) ->
  console.log [
    "BUILD FAILED: #{error.name ? ''}".red.underline
    '\u0007' # beep
    "#{error.code ? ''}"
    "#{error.message ? error}"
    "in #{error.filename ? ''}"
    "gulp plugin: #{error.plugin ? ''}"
  ].join "\n"
  this.end()

# clean build dir
gulp.task "clean", ->
  gulp.src([
      webDir
      webapp
    ], read: false)
    .pipe remove force: true

# clean generated src js
gulp.task "clean-gen-src", ->
  gulp.src(genJsSrc, read: false)
    .pipe(remove force: true)

# clean generated test js
gulp.task "clean-gen-test", ->
  gulp.src(genJsTest, read: false)
    .pipe(remove force: true)

# clean generated js
gulp.task "clean-gen", [
  "clean-gen-src"
  "clean-gen-test"
]

compile = (srcDir) ->
  gulp.src(srcDir + coffeeFiles)
    .pipe(coffee bare: true)
      .on("error", log)
    .pipe(gulp.dest srcDir)

gulp.task "coffee-src", ->
  compile srcDir

gulp.task "coffee-test", ->
  compile testDir

gulp.task "coffee", [
  "coffee-src"
  "coffee-test"
]

# combine and min js files into build dir
gulp.task "js", ["coffee-src", "css"], ->
  gulp.src(javascripts)
    .pipe(concat mainJs)
    .pipe(uglify())
    .pipe(gulp.dest webDir)

# combine and min css files into build dir
gulp.task "css", ->
  gulp.src(stylesheets)
    .pipe(prefixer browsers: ["last 2 versions"])
    .pipe(concat mainCss)
    .pipe(minifycss compatibility: "ie8")
    .pipe(gulp.dest webDir)

# min images into build dir
gulp.task "img", ->
  gulp.src(images, base: srcDir)
    .pipe(imagemin())
      .on("error", log)
    .pipe(gulp.dest webDir)
    .pipe(connect.reload())

# copy fonts into build dir
gulp.task "fonts", ->
  gulp.src(fontAwesome)
    .pipe(gulp.dest fontsDir)
    .pipe(connect.reload())

# replace and min html into build dir
gulp.task "html", ->
  gulp.src(htmls, base: srcDir)
    .pipe replace
      "css": "#{mainCss}?v=#{cssVer}"
      "js": "#{mainJs}?v=#{jsVer}"
    .pipe minifyhtml
      conditionals: true
      quotes: true
      spare: true
    .pipe(gulp.dest webDir)

gulp.task "build", [
  "coffee-src"
  "fonts"
  "html"
  "img"
  "css"
  "js"
]

# run compiled sources
gulp.task "serve", serve [webDir]

# run html task by default
gulp.task "default", ["build"]

# combine and min js files into build dir
gulp.task "js-map", ["coffee-src", "css-map"], ->
  gulp.src(javascripts)
    .pipe(sourcemaps.init())
    .pipe(concat mainJs)
    .pipe(uglify())
    .pipe(sourcemaps.write mapsDir)
    .pipe gulp.dest webDir

# combine and min css files into build dir
gulp.task "css-map", ->
  gulp.src(stylesheets)
    .pipe(sourcemaps.init())
    .pipe(prefixer browsers: ["last 2 versions"])
    .pipe(concat mainCss)
    .pipe(minifycss compatibility: "ie8")
    .pipe(sourcemaps.write mapsDir)
    .pipe gulp.dest webDir

gulp.task "maps", [
  "coffee-src"
  "fonts"
  "html"
  "img"
  "css-map"
  "js-map"
]

gulp.task "dev-js", ->
  gulp.src(javascripts)
    .pipe(gulp.dest webapp)
    .pipe connect.reload()

gulp.task "dev-css", ->
  gulp.src(stylesheets)
    .pipe(gulp.dest webapp)
    .pipe connect.reload()

# min images into build dir
gulp.task "dev-img", ->
  gulp.src(images, base: srcDir)
    .pipe(gulp.dest webapp)
    .pipe connect.reload()

# copy fonts into build dir
gulp.task "dev-fonts", ->
  gulp.src(fontAwesome)
    .pipe(gulp.dest webapp + fonts)
    .pipe connect.reload()

gulp.task "dev-html", ->
  gulp.src(htmls, base: srcDir)
    .pipe(gulp.dest webapp)
    .pipe connect.reload()

gulp.task "dev", [
  "coffee"
  "dev-fonts"
  "dev-img"
  "dev-html"
  "dev-css"
  "dev-js"
]

gulp.task "test-js", ["dev-js", "test-coffee"], (done) ->
  new Server(
      configFile: karmaJsConf
      singleRun: true,
    done)
  .start()

gulp.task "test-coffee", (done) ->
  new Server(
      configFile: karmaCoffeeConf
      singleRun: true,
    done)
  .start()

gulp.task "test", [
  "test-coffee"
  "test-js"
]

gulp.task "connect", ->
  connect.server
    port: 3000
    root: webapp
    livereload: true

# watch files into build
gulp.task "watch", [
  "connect"
  "dev"
], ->
  gulp.watch stylesheets, ["dev-css"]
  gulp.watch htmls, ["dev-html"]
  gulp.watch webapp + fonts, ["dev-fonts"]
  gulp.watch images, ["dev-img"]
  gulp.watch srcDir + coffeeFiles, [
    "test-coffee"
    "coffee-src"
    "dev-js"
  ]
  gulp.watch testDir + coffeeFiles, [
    "test-coffee"
    "coffee-test"
    "dev-js"
  ]
  gulp.watch [
    webapp
    genJsSrc
    genJsTest
  ], ["test-js"]
