'use strict';

angular
  .module('blogMain', [])
  .directive('blogMain', function() {
    return {
      restrict: 'E',
      templateUrl: '../html/directives/blog-main.html',
      replace: true
    }
  });