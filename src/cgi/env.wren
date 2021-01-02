
class Env {
  // Segmentation fault if name arg is null
  // so a wrapper is needed for public api
  foreign static f_get(name)
  static get(name) {
    if (name is String && name.trim().count > 0) {
      return f_get(name)
    }
    return ""
  }

  // f_all only return the names
  // the map must be done in Wren, not in C
  // due to the lack of apis of Wren 0.3
  foreign static f_all
  static all {
    var env = {}
    f_all.each{|name|
      env[name] = f_get(name)
    }
    return env
  }
}

/*
A map of variables
passed to the current script via the URL parameters
(aka. query string).
Note that the map is not only populated for GET requests,
but rather for all requests with a query string.
*/
class Get {
  foreign static f_query
  static query {f_query}
}
