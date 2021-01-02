import "os" for Platform

class Response {
  static echobag_ {
    if (!__echobag) {
      __echobag = []
    }
    return __echobag
  }

  static echo(text) {
    echobag_.add(text.toString)
  }

  static clear() {
    __echobag = []
  }

  static toString {Headers.build + echobag_.join()}
  static build {toString}
}

class Headers {
  static items {
    if (!__items) {
      __items = {
        "X-Powered-By": "Wren CGI",
        "Content-Type": "text/html; charset=UTF-8"
      }
    }
    return __items
  }

  static set(name, value) {
    items[name.toString] = value.toString
  }

  static toString {
    var out = ""
    items.keys.each {|key|
      out = out + key + ":" + items[key] + Platform.eol
    }
    return out
  }

  static build {toString}
}
