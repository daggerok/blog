angular
  .module 'blogMain', []
    .directive 'blogMain', () ->
      restrict: 'E'
      templateUrl: 'html/directives/blog-main.html'
      replace: true
