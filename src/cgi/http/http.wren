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

  static toString {Response.build()}
  static build() {echobag_.join()}
  static send() {
    Headers.send()
    System.print(Response.build())
    Response.clear()
  }
}

class Headers {
  static sent {__sent}

  static default {{
    "X-Powered-By": "Wren CGI",
    "Content-Type": "text/html; charset=UTF-8",
    "Status": "200 OK"
  }}

  static items {
    if (!__items) {
      __items = Headers.default
    }
    return __items
  }

  static set(name, value) {
    items[name.toString] = value.toString
  }

  static toString {Headers.build()}

  static build() {
    var out = ""
    items.keys.each {|key|
      out = out + key + ":" + items[key] + Platform.eol
    }
    return out
  }

  static send() {
    System.print(Headers.build())
    __sent = true
  }
}

class Status {
  static set(code) {
    Headers.set("Status", code)
  }

  static set(code, message) {
    Headers.set("Status", "%(code) %(message)")
  }

  static ok(message) {set(200, message)}
  static ok() {ok("")}
}
