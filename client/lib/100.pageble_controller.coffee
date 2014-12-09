varName = (inst, name = null) ->
  name = name && "_#{name}" || ""
  "#{inst.constructor.name}#{name}_limit"

_.mixings = (classes...)->
  classes.reduceRight (Parent, Child)->
    class Child_Projection extends Parent
      constructor: ->
        # Temporary replace Child.__super__ and call original `constructor`
        child_super = Child.__super__
        Child.__super__ = Child_Projection.__super__
        Child.apply @, arguments
        Child.__super__ = child_super

        # If Child.__super__ not exists, manually call parent `constructor`
        unless child_super?
          super

    # Mixin prototype properties, except `constructor`
    for own key  of Child::
      if Child::[key] isnt Child
        Child_Projection::[key] = Child::[key]

    # Mixin static properties, except `__super__`
    for own key  of Child
      if Child[key] isnt Object.getPrototypeOf(Child::)
        Child_Projection[key] = Child[key]

    Child_Projection

class @PagebleRouteController extends RouteController

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