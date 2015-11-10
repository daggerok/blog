/**
 * Created by mak on 11/10/15.
 */
module.exports = function (config) {
  config.set({
    basePath: '../',
    files: [
      'src/js/**/*.js',
      'test/unit/**/*.js'
    ],
    autoWatch: false,
    frameworks: ['jasmine'],
    browsers: ['Chrome'],
    plugins: [
      'karma-chrome-launcher',
      'karma-jasmine'
    ],
    junitReporter: {
      outputFile: '../build/test-results/karma-test-report.xml',
      suite: 'unit'
    }
  });
};
