angular
  .module 'blogNav', []
    .directive 'blogNav', () ->
      restrict: 'E'
      templateUrl: 'html/directives/blog-nav.html'
      replace: true
