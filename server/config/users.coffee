Accounts.onCreateUser (options = {}, user) ->
  u = UsersCollection._transform(user)
  options.profile ||= {}
  # запоминаем сервис, через который пользователь зарегистрировался
  options.service = _(user.services).keys()[0] if user.services
  # сохраняем дополнительные параметры и возвращаем объект,
  # который запишется в бд
  options.role ||= []
  _.extend user, options

