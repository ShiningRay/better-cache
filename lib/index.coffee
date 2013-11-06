memoryCache = require 'memory-cache'

exports.fetch = (key, fn, params, cacheCallback) ->
  
  return cacheCallback(memoryCache.get(key)) if memoryCache.get(key)
  cb = (returned_val) ->
    memoryCache.put(key, returned_val)
    cacheCallback(returned_val)
  params.push(cb)
  fn.apply(null, params)

exports.clear = () ->
  memoryCache.clear()

exports.remove = (key) ->
  memoryCache.del(key)

exports.size = () ->
  memoryCache.size()

