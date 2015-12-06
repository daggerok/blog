angular
  .module 'i18nConfig', ['pascalprecht.translate']
    .config [
      '$translateProvider'
      ($translateProvider) ->
        $translateProvider
          .preferredLanguage 'ru'
          # escape html
          .useSanitizeValueStrategy 'escape'
          # english internationalization:
          .translations 'en',
            i18nTest: "Some text.."
            i18nHeadName: "Maksim Kostromin"
            i18nHeadIt: "IT"
            i18nHeadMusic: "Music"
            i18nHeadPhoto: "Photo"
            i18nHeadSport: "Sport"
            i18nHeadLangEn: "en"
            i18nHeadLangRu: "ru"
            i18nHeadAbout: "About"
            i18nContacts: "Contacts"
            i18nPageNotFound: "Sorry, but page wasn't found"
            i18nFooterCopyright: "copyright"
            i18nFooterDaggerok: "developed by daggerok"
          # русская интернационализация:
          .translations 'ru',
            i18nTest: "Какой-то текст.."
            i18nHeadName: "Максим Костромин"
            i18nHeadIt: "ИТ"
            i18nHeadMusic: "Музыка"
            i18nHeadPhoto: "Фотография"
            i18nHeadSport: "Спорт"
            i18nHeadLangEn: "англ"
            i18nHeadLangRu: "руск"
            i18nHeadAbout: "Обо мне"
            i18nContacts: "Контакты"
            i18nPageNotFound: "К сожалению, страница не найдена"
            i18nFooterCopyright: "все права защищены"
            i18nFooterDaggerok: "разработано Даггерком"
    ]
