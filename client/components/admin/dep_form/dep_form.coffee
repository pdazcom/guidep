mainDep =
  _id: ''
  title: {}

getMainDep = (dep)->
  mainDepId = _.ref(dep, 'main_dep') || false
  if !mainDepId
    return false
  mainDep = DepartmentsCollection.findOne _id: mainDepId, {
    fields:
      _id: 1
      title: 1
  }
  return mainDep

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
    mainDep = getMainDep data.dep
    if !mainDep
      return if field == 'title' then i18n 'general.empty' else false

    if field == 'title'
      lang = i18n.getLanguage()
      field = "#{field}.#{lang}"

    return _.ref(mainDep, field) || (if lang then i18n 'general.empty' else false)

  valueMainDepTitle: ->
    mainDep = getMainDep @dep
    if !mainDep
      return ""

    lang = i18n.getLanguage()
    field = "title.#{lang}"
    return _.ref(mainDep, field) || ""

  submitButton: (editDep)->
    if editDep then i18n "general.save" else "general.create"

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
    console.log dep
    dep.status?.hidden = true
    if dep.status
      if dep.status.hidden
        dep.status.hidden = true
      if dep.status.new
        dep.status.new = true
    action = if @editDep then 'update' else 'create'
    DepartmentsCollection["#{action}Dep"] dep, (err, e)->
      if err
        alertify.error err.msg
      else
        form.reset()
        msg = action.charAt(0).toUpperCase() + action.slice 1
        alertify.success i18n "deps.dep#{msg}Success"
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
    if !mainDep
      mainDep =
        _id: ''
        title: {}
    mainDep._id = $("input#main_dep").val()
    mainDep.title[i18n.getLanguage()] = if (!mainDep._id.length) then '' else _this.html()