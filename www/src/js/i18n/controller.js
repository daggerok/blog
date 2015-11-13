'use strict';

angular
  .module('i18nController', ['pascalprecht.translate'])
  .controller('i18nController', ['$scope', '$translate', function($scope, $translate) {
      $scope.changeLanguage = function(langKey) {
        $translate.use(langKey);
      }
    }
  ]);