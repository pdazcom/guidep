depTitleObj = {}
_.each i18n.getAvailableLanguages(), (v)->
  depTitleObj[v] =
    type: String

depTitleSchema = new SimpleSchema depTitleObj
depStatusSchema = new SimpleSchema
  hidden:
    type: Boolean
    optional: true
  new:
    type: Boolean
    optional: true

depSchema = SimpleSchema.build SimpleSchema.timestamp,
  title:
    type: depTitleSchema
  synonyms:
    type: String
  use_count:
    type: Number
    optional: true
    min: 0
  main_dep:
    type: String
    optional: true
  status:
    type: depStatusSchema
    optional: true

Departments = new Mongo.Collection 'departments'
Departments.attachSchema depSchema

allow = (userId)->
  if !userId
    return false
  UsersCollection.findOne({ _id: userId}, {fields: { role: 1 }}).hasAccess 'admin'

Departments.allow
  insert: (userId, doc)->
    allow userId

  update: (userId, doc)->
    allow userId

_.extend Departments,
  createDep: (data, cb)->
    @insert data, cb

  updateDep: (data, cb)->
    if !data._id
      throw new Meteor.error i18n "deps.errorUpdateNoDepID"
    depId = data._id
    delete data._id
    @update _id: depId, { $set: data }, cb

@DepartmentsCollection = Departments