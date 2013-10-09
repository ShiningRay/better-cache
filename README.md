better-Cache
============


Rails like caching for node.


## Example

      cache.fetch('user', getUser, [id], function (user) {
        // do next thing :)
        // the user variable in the callback below is now in cache
        //the getUser function won't be called next time you call cache.fetch with 'user' as the key
        //in fact cache.fetch('key') will work.
      })

      getUser = function (id, callback) {
        User.find(id).success(function (user) {
          callback(user)
        })
      }

Which is much easier than something like this:

      if (otherCacheModule.get('users')) {
        thing_to_do_next_that_I_have_to_put_in_a_function(otherCacheModule.get('users')) //because otherwise I've to write everything in this if, and duplicate any overlapping code with the below else
      }
      else {
        getUsers(function (users) {
          otherCacheModule.put('users', users)
          thing_to_do_next_that_I_have_to_put_in_a_function(users) //because otherwise I've to write everything in this else, and duplicate any overlapping code with the above if. Sound Familiar?
        }) 
      }

A little prettier no? The main reason I built this is because I love how in rails you can just use 

      Rails.cache.fetch('key', do ... end)

and it'll worry about all the scenarios for you (when its cached, when its not). Furthermore, as you can see above, trying to do this in nodelike above is just ridiculous. A lot of the time, I was also caching the results of functions, all with callbacks of course, which made it even messier. So hence better-cache was hacked together while bored in a lecture one day.


You can also do:

    cache.remove(key) //key 
    cache.clear() //clear all
    cache.size() // 0

## Installation

    npm install better-cache

## Syntax

    var cache = require('better-cache');

    cache.fetch(key, fn, params, callback)

  fn is a function you define that takes in any number of params, the last of which is a callback function. Params is the params you want to pass in, minus the callback function (we'll take care of that). Whatever you return in that callback function (the last param of the fn function) will be cached, and next time you run cache.fetch(key) it'll get the cached result rather than running the function.

  The only preresiquite is that you don't use the variable name 'cacheCallback' in the fn function :)

  cache.remove(), cache.clear(), cache.size() should all be pretty self-explanatory from the example above.


## To-do

  1. Move away from dependency on memory cache.
  2. Ability to Expire cache



Feel free to fork, or add any issues you notice.
Pull requests are of course always welcome. I'm using coffeescript for this, so edit that, not the js file then compile (bare)