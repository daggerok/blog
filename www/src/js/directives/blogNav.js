'use strict';

angular
  .module('blogNav', [])
  .directive('blogNav', function() {
    return {
      restrict: 'E',
      templateUrl: '../html/directives/blog-nav.html',
      replace: true
    }
  });