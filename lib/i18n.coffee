i18n.setDefaultLanguage 'en'

i18n.getAvailableLanguages = ->
  return ['en', 'ru']

i18n.identLanguage = (language) ->
  if language.match /fr/
    language = 'fr'
  if language.match /ru/
    language = 'ru'
  else
    language = 'en'

  return language