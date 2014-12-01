Meteor.publish 'adminDeps', (limit = 20)->
  # проверям авторизован ли пользователь,
  # запрашивающий подписку
  user = null
  if @userId
    user = UsersCollection.findOne { _id: @userId }, { fields : { role: 1 }}

  if user && user.hasAccess "admin"
  # подписываем на его запись в бд
    DepartmentsCollection.find {}, limit: limit || 20
  else
    # просто говорим, что все готово
    @ready()
    return