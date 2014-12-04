Meteor.startup ->
  if Meteor.isClient
    if Meteor.user()
      language = Meteor.user().profile.language  # see step 6.

    else
      #detect the language used by the browser
      language = window.navigator.userLanguage || window.navigator.language
      language = i18n.identLanguage language
    console.log "Useragent language: #{language}"
    i18n.setLanguage language

    console.log "Current language: #{i18n.getLanguage()}"