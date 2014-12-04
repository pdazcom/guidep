Meteor.publish 'adminDeps', (limit = 20) ->
  # проверям авторизован ли пользователь,
  # запрашивающий подписку
  user = null
  if @userId
    user = UsersCollection.findOne { _id: @userId }, { fields : { role: 1 }}

  if !user or !user.hasAccess "admin"
    # просто говорим, что все готово
    @ready()
    return

  deps = DepartmentsCollection.find({}, limit: limit || 20)

  inited = false
  mainDepsFindOptions =
    fields:
      title: 1
      _id: 1
      main_dep: 1
  addMainDep = (id, fields) =>
    if inited
      depId = fields.main_dep
      console.log depId
      @added 'departments', depId, DepartmentsCollection.findOne(depId, mainDepsFindOptions)

  handle = deps.observeChanges
    added: addMainDep
    changed: addMainDep

  inited = true
  mainDepIds = []
  deps.forEach (b) ->
    if !b.main_dep
      return false
    mainDepIds.push b.main_dep

  console.log mainDepIds
  DepartmentsCollection.find({_id: { $in: mainDepIds }}, mainDepsFindOptions).forEach (doc)=>
    @added 'departments', doc._id, doc

  @onStop ->
    handle.stop()

  return deps

Meteor.publish 'autocompleteDeps', (options) ->
  console.log options
  DepartmentsCollection.find options,
    limit: 20
    fields:
      _id: 1
      title: 1