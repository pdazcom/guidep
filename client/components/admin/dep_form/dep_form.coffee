Template.depForm.helpers
  settings: ->
    position: "bottom"
    limit: 20
    rules: [
      token: ''
      collection: 'DepartmentsCollection'
      subscription: 'autocompleteDeps'
      field: "title.#{i18n.getLanguage()}"
      options: 'i'
      matchAll: true
      template: Template.autocompleteDep
      selector: (filter)->
        "synonyms":
          $regex: if @matchAll then filter else "^" + filter
          $options: if (typeof @options is 'undefined') then 'i' else @options
      callback: (doc, el)->
        $("input#main_dep").val doc._id
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

    DepartmentsCollection.createDep dep, (err, e)->
      console.log e
      if err
        alertify.error err.msg
      else
        form.reset()
        alertify.success i18n 'deps.depCreatedSuccess'
        Router.go 'deps'

