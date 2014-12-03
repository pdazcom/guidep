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

Departments.allow
  insert: (userId, doc)->
    if !userId
      false

    UsersCollection.findOne({ _id: userId}, {fields: { role: 1 }}).hasAccess 'admin'

_.extend Departments,
  createDep: (data, cb)->
    @insert data, cb
@DepartmentsCollection = Departments