mainDep =
  _id: ''
  title: {}

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
        submitMainDep(null, doc)
    ]

  mainDepPlaceholder: ->
    i18n 'deps.mainDep'

  langs: ()->
    i18n.getAvailableLanguages()

  valueDep: (data, field, lang)->
    if arguments.length > 3
      field = "#{field}.#{lang}"
    if !data.editDep
      return false
    _.ref(data.dep, field) || false

  valueMainDep: (data, field)->
    mainDepId = @valueDep data, 'main_dep'
    if !mainDepId
      return i18n 'general.empty'
    mainDep = DepartmentsCollection.findOne _id: mainDepId, fields:
      _id: 1
      title: 1
    if field == 'title'
      lang = i18n.getLanguage()
      field = "#{field}.#{lang}"

    return _.ref(mainDep, field) || (if lang then i18n 'general.empty' else false)

submitMainDep = (e, doc)->
  if e
    e.preventDefault()
  a = $("#main_dep_edit")
  if !doc._id.length
    a.removeClass("hidden").html i18n 'general.empty'
  else
    a.removeClass("hidden").html doc.title[i18n.getLanguage()]
  $("#maindep_title").addClass "hidden"
  $("input#main_dep").val doc._id
  $("#main_dep_input").val doc.title[i18n.getLanguage()]

cancelMainDep = (e)->
  submitMainDep(e, mainDep)

clearMainDep = (e)->
  mainDep =
    _id: ''
    title: {}
  submitMainDep e, mainDep

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
      if err
        alertify.error err.msg
      else
        form.reset()
        alertify.success i18n 'deps.depCreatedSuccess'
        Router.go 'deps'

  'click .editable-cancel': (event)->
    cancelMainDep event

  'click .editable-clear-x': (event)->
    clearMainDep(event)

  'click a#main_dep_edit': (event) ->
    event.preventDefault()
    _this = $(event.target)
    _this.addClass "hidden"
    $("#maindep_title").removeClass "hidden"
    mainDep._id = $("input#main_dep").val()
    mainDep.title[i18n.getLanguage()] = if _this.html() == i18n 'general.empty' then '' else _this.html()