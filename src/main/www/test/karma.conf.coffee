'use strict'

# Karma configuration
# Generated on Tue Nov 10 2015 02:26:59 GMT+0200 (EET)
module.exports = (config) ->
  modules = '../../../node_modules'
  cfg =
    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '..'

    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine']

    plugins: [
      'karma-phantomjs-launcher'
      'karma-firefox-launcher'
      'karma-chrome-launcher'
      'karma-safari-launcher'
      'karma-opera-launcher'
      'karma-junit-reporter'
      'karma-ie-launcher'
      'karma-jasmine'
    ]

    # list of files / patterns to load in the browser
    files: [
      # vendors
      "#{modules}/jquery/dist/jquery.js"
      "#{modules}/angular/angular.js"
      "#{modules}/angular-route/angular-route.js"
      "#{modules}/angular-translate/dist/angular-translate.js"
      "#{modules}/angular-mocks/angular-mocks.js"
      # app
      'src/**/*.js'
      # test
      'test/**/*.test.js'
    ]

    # list of files to exclude
    exclude: [
      #src/some/specify/scenario.js
      #test/some/specify/scenario.test.js
    ]

    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {}

    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: [
      'progress'
      'junit'
    ]

    # the default configuration
    junitReporter:
      # results will be saved as $outputDir/$browserName.xml
      outputDir: '../../../build'
      # if included, results will be saved as $outputDir/$browserName/$outputFile
      outputFile: undefined
      # suite will become the package name attribute in xml testsuite element
      suite: ''
      # add browser name to report and classes names
      useBrowserName: true

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: false

    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: [
      'PhantomJS'
      #'Internet Explorer'
      #'Firefox'
      #'Chrome'
      #'Safari'
      #'Opera'
    ]

    customLaunchers:
      Chrome_travis_ci:
        base: 'Chrome'
        flags: ['--no-sandbox']

    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: true

    # Concurrency level
    # how many browser should be started simultanous
    concurrency: Infinity

  cfg.browsers = ['Chrome_travis_ci'] if process.env.TRAVIS?

  config.set cfg