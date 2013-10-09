memoryCache = require 'memory-cache'

fetch = (key, fn, params, cacheCallback) ->
  
  return cacheCallback(memoryCache.get(key)) if memoryCache.get(key)
  cb = (returned_val) ->
    console.log 'in cb', returned_val
    memoryCache.put(key, returned_val)
    cacheCallback(returned_val)
  params.push(cb)
  fn.apply(null, params)

clear = () ->
  memoryCache.clear()

remove = (key) ->
  memoryCache.del(key)

size = () ->
  memoryCache.size()

exports.fetch = fetch
exports.clear = clear
exports.remove = remove
exports.size = size

