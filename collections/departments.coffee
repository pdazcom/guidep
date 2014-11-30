_tmp = {}
langs = i18n.getAvailableLanguages()
_.each langs, (v)->
  _tmp[v] =
    type: String

depTitleSchema = new SimpleSchema _tmp
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
    type: Object
    optional: true

Departments = new Mongo.Collection 'departments'
Departments.attachSchema depSchema

@DepartmentsCollection = Departments