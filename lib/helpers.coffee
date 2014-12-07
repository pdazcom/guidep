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

