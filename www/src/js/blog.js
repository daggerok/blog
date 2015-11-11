'use strict';
angular.module('blog', [])
  .directive('blogHeader', function() {
    return {
      restrict: 'E',
      replace: 'true',
      templateUrl: '../html/blog-header.html'
    }
  })
  .directive('blogFooter', function() {
    return {
      restrict: 'E',
      replace: 'true',
      templateUrl: '../html/blog-footer.html'
    }
  });