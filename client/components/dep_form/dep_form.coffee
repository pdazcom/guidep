Template.depForm.helpers
  settings: ->
    position: "top"
    limit: 5
    rules: [
      token: '!'
      collection: DepartmentsCollection
      field: "_id"
      options: ''
      matchAll: true
      filter:
        type: "autocomplete"
      template: Template.dataPiece
    ]

  mainDepPlaceholder: ->
    i18n 'deps.mainDep'

  langs: ->
    i18n.getAvailableLanguages()

Template.depForm.events
  'submit #dep_form': (event) ->
    event.preventDefault()
    form = $("#dep_form").serializeJSON()
    form.status?.hidden = true
    if form.status
      if form.status.hidden
        form.status.hidden = true
      if form.status.new
        form.status.new = true

    DepartmentsCollection.insert form

    console.log form
