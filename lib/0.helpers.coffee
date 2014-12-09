_.deepExtend = (target, source) ->
  for prop of source
    if _.isObject(target[prop])
      _.deepExtend target[prop], source[prop]
    else
      target[prop] = source[prop]
  return target

_.ref = (obj, str) ->
  return str.split(".").reduce((o, x)->
    o?[x]
  , obj)

_.set = (obj, str, val) ->
  str = str.split "."
  while (str.length > 1)
    obj = obj[str.shift()]
  obj[str.shift()] = val

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