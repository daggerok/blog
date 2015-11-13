'use strict';

angular
  .module('routes', ['ngRoute'])
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'html/routes/main.html'
      })

      .when('/about', {
        templateUrl: 'html/routes/about.html'
      })

      .when('/contacts', {
        templateUrl: 'html/routes/contacts.html'
      })

      .otherwise({
        templateUrl: 'html/routes/404.html'
      });
  }]);
