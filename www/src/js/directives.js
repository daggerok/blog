'use strict';

angular.module('directives', [])
  .directive('blogNav', function () {
    return tag('../html/blog-nav.html')
  })
  .directive('blogMain', function () {
    return tag('../html/blog-main.html')
  })
  .directive('blogFooter', function () {
    return tag('../html/blog-footer.html')
  });

function tag(url) {
  return {
    restrict: 'E',
    templateUrl: url,
    replace: true
  };
}
