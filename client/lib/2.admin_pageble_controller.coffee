varName = (inst, name = null) ->
  name = name && "_#{name}" || ""
  "#{inst.constructor.name}#{name}_limit"

class @AdminPagableRouteController extends AdminRouteController

  pageable: true # будем проверять, что это за контроллер
  perPage: 20    # количество данных на одной странице

  # количество загружаемых данных
  limit: (name = null) ->
    Session.get(varName(@, name)) || @perPage

  # следующая страница
  incLimit: (name = null, inc = null) ->
    inc ||= @perPage
    Session.set varName(@, name), (@limit(name) + inc)

  # сборс количества
  resetLimit: (name = null) ->
    Session.set varName(@, name), null

  # все ли данные были загруженны?
  loaded: (name = null) ->
    true