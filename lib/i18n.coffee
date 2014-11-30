i18n.setDefaultLanguage 'en_US'

i18n.getAvailableLanguages = ->
  return ['en_US', 'ru_RU']

i18n.getLanguage = (language) ->
  if language.match /fr/
    language = 'fr_FR'
  if language.match /ru/
    language = 'ru_RU'
  else
    language = 'en_US'

  return language