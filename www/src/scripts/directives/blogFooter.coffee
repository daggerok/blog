angular
  .module 'blogFooter', []
    .directive 'blogFooter', () ->
      restrict: 'E'
      templateUrl: 'html/directives/blog-footer.html'
      replace: true
