@getLanguage = (language) ->
  if language.match /fr/
    language = 'fr_FR'
  if language.match /ru/
    language = 'ru_RU'
  else
    language = 'en_US'

  return language