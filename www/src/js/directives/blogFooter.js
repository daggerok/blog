'use strict';

angular
  .module('blogFooter', [])
  .directive('blogFooter', function() {
    return {
      restrict: 'E',
      templateUrl: '../html/directives/blog-footer.html',
      replace: true
    }
  });