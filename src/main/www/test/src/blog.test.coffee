describe 'blog modules', ->

  it 'blog be defined', ->
    expect angular.module 'blog'
      .toBeDefined()

  describe 'dependencies', ->

    it 'directives be defined', ->
      expect angular.module 'directives'
        .toBeDefined()

    it 'controllers be defined', ->
      expect angular.module 'controllers'
        .toBeDefined()

    it 'routes be defined', ->
      expect angular.module 'routes'
        .toBeDefined()

    it 'i18n be defined', ->
      expect angular.module 'i18n'
        .toBeDefined()

    it 'should throw if module is not defined', ->
      expect( => angular.module 'i18nnn').toThrow()