Template.depForm.helpers
  settings: ->
    position: "top"
    limit: 5
    rules: [
      token: ''
      collection: 'DepartmentsCollection'
      subscription: 'autocompleteDeps'
      field: "synonyms"
      options: 'i'
      matchAll: true
      template: Template.autocompleteDep
    ]

  mainDepPlaceholder: ->
    i18n 'deps.mainDep'

  langs: ->
    i18n.getAvailableLanguages()

Template.depForm.events
  'submit #dep_form': (event) ->
    event.preventDefault()
    form = event.target
    dep = $(form).serializeJSON()
    dep.status?.hidden = true
    if dep.status
      if dep.status.hidden
        dep.status.hidden = true
      if dep.status.new
        dep.status.new = true

    DepartmentsCollection.createDep dep, (err)->
      if err
        alertify.error err.msg
      else
        form.reset()
        alertify.success i18n 'deps.depCreatedSuccess'
        Router.go 'deps'

    console.log form
