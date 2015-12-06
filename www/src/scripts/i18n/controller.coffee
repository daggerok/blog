angular
  .module 'i18nController', ['pascalprecht.translate']
    .controller 'i18nController', [
      '$scope', '$translate'
      ($scope, $translate) ->
        $scope.changeLanguage = (langKey) ->
          $translate.use langKey
    ]
