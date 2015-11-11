'use strict';

angular.module('directives', [])
  .directive('blogNav', function() {
    return {
      restrict: 'E',
      templateUrl: 'html/blog-nav.html',
      replace: true
    }
  })
  .directive('blogMain', function() {
    return {
      restrict: 'E',
      templateUrl: '../html/blog-main.html',
      replace: true
    }
  })
  .directive('blogFooter', function() {
    return {
      restrict: 'E',
      templateUrl: 'html/blog-footer.html',
      replace: true
    }
  });