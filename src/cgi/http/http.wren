import "os" for Platform
import "env" for Request

// TODO: Make it an instance instead of static
class Response {
  static headers {Headers}
  static status {Status}

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
  static set(code, message) {
    var status = "%(code) %(message)"
    Headers.set("Status", status)
    return status
  }

  static set(code) {Headers.set("Status", code)}

  // Only the most used ones
  // Have shortcuts
  static ok {
    if (!__ok) {
      __ok = HTTPStatus.status_200
    }
    return __ok
  }

  static ok(message) {set(ok.code, message)}
  static ok() {ok(ok.message)}

  static notFound {
    if (!__notFound) {
      __notFound = HTTPStatus.status_404
    }
    return __notFound
  }

  static notFound(message) {set(notFound.code, message)}
  static notFound() {notFound(notFound.message)}

  static forbidden {
    if (!__forbidden) {
      __forbidden = HTTPStatus.status_403
    }
    return __forbidden
  }

  static forbidden(message) {set(forbidden.code, message)}
  static forbidden() {forbidden(forbidden.message)}

  static internalServerError {
    if (!__internalServerError) {
      __internalServerError = HTTPStatus.status_500
    }
    return __internalServerError
  }

  static internalServerError(message) {set(internalServerError.code, message)}
  static internalServerError() {internalServerError(internalServerError.message)}
}

// Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
class HTTPStatus {
  code {_code}
  message {_message}
  toString {"%(this.code) %(this.message)"}

  construct new(code, message) {
    _code = code
    _message = message
  }

  static status_100 {HTTPStatus.new(100, "Continue")}
  static status_101 {HTTPStatus.new(101, "Switching Protocol")}
  static status_102 {HTTPStatus.new(102, "Processing")}
  static status_103 {HTTPStatus.new(103, "Early Hints")}

  static status_200 {HTTPStatus.new(200, "OK")}
  static status_201 {HTTPStatus.new(201, "Created")}
  static status_202 {HTTPStatus.new(202, "Accepted")}
  static status_203 {HTTPStatus.new(203, "Non-Authoritative Information")}
  static status_204 {HTTPStatus.new(204, "No Content")}
  static status_205 {HTTPStatus.new(205, "Reset Content")}
  static status_206 {HTTPStatus.new(206, "Partial Content")}
  static status_207 {HTTPStatus.new(207, "Multi-Status")}
  static status_208 {HTTPStatus.new(208, "Already Reported")}
  static status_226 {HTTPStatus.new(226, "IM Used")}

  static status_300 {HTTPStatus.new(300, "Multiple Choice")}
  static status_301 {HTTPStatus.new(301, "Moved Permanently")}
  static status_302 {HTTPStatus.new(302, "Found")}
  static status_303 {HTTPStatus.new(303, "See Other")}
  static status_304 {HTTPStatus.new(304, "Not Modified")}
  static status_305 {HTTPStatus.new(305, "Use Proxy")}
  static status_307 {HTTPStatus.new(307, "Temporary Redirect")}
  static status_308 {HTTPStatus.new(308, "Permanent Redirect")}

  static status_400 {HTTPStatus.new(400, "Bad Request")}
  static status_401 {HTTPStatus.new(401, "Unauthorized")}
  static status_402 {HTTPStatus.new(402, "Payment Required")}
  static status_403 {HTTPStatus.new(403, "Forbidden")}
  static status_404 {HTTPStatus.new(404, "Not Found")}
  static status_405 {HTTPStatus.new(405, "Method Not Allowed")}
  static status_406 {HTTPStatus.new(406, "Not Acceptable")}
  static status_407 {HTTPStatus.new(407, "Proxy Authentication Required")}
  static status_408 {HTTPStatus.new(408, "Request Timeout")}
  static status_409 {HTTPStatus.new(409, "Conflict")}
  static status_410 {HTTPStatus.new(410, "Gone")}
  static status_411 {HTTPStatus.new(411, "Length Required")}
  static status_412 {HTTPStatus.new(412, "Precondition Failed")}
  static status_413 {HTTPStatus.new(413, "Payload Too Large")}
  static status_414 {HTTPStatus.new(414, "URI Too Long")}
  static status_415 {HTTPStatus.new(415, "Unsupported Media Type")}
  static status_416 {HTTPStatus.new(416, "Range Not Satisfiable")}
  static status_417 {HTTPStatus.new(417, "Expectation Failed")}
  static status_418 {HTTPStatus.new(418, "I'm a teapot")}
  static status_421 {HTTPStatus.new(421, "Misdirected Request")}
  static status_422 {HTTPStatus.new(422, "Unprocessable Entity")}
  static status_423 {HTTPStatus.new(423, "Locked")}
  static status_424 {HTTPStatus.new(424, "Failed Dependency")}
  static status_425 {HTTPStatus.new(425, "Too Early")}
  static status_426 {HTTPStatus.new(426, "Upgrade Required")}
  static status_428 {HTTPStatus.new(428, "Precondition Required")}
  static status_429 {HTTPStatus.new(429, "Too Many Requests")}
  static status_431 {HTTPStatus.new(431, "Request Header Fields Too Large")}
  static status_451 {HTTPStatus.new(451, "Unavailable For Legal Reasons")}

  static status_500 {HTTPStatus.new(500, "Internal Server Error")}
  static status_501 {HTTPStatus.new(501, "Not Implemented")}
  static status_502 {HTTPStatus.new(502, "Bad Gateway")}
  static status_503 {HTTPStatus.new(503, "Service Unavailable")}
  static status_504 {HTTPStatus.new(504, "Gateway Timeout")}
  static status_505 {HTTPStatus.new(505, "HTTP Version Not Supported")}
  static status_506 {HTTPStatus.new(506, "Variant Also Negotiates")}
  static status_507 {HTTPStatus.new(507, "Insufficient Storage")}
  static status_508 {HTTPStatus.new(508, "Loop Detected")}
  static status_510 {HTTPStatus.new(510, "Not Extended")}
  static status_511 {HTTPStatus.new(511, "Network Authentication Required")}
}

// Reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
class MimeType {

  static aac {"audio/aac"}
  static abw {"application/x-abiword"}
  static arc {"application/x-freearc"}
  static avi {"video/x-msvideo"}
  static azw {"application/vnd.amazon.ebook"}
  static bin {"application/octet-stream"}
  static bmp {"image/bmp"}
  static bz  {"application/x-bzip"}
  static bz2 {"application/x-bzip2"}
  static csh {"application/x-csh"}
  static css {"text/css"}
  static csv {"text/csv"}
  static doc {"application/msword"}

  static docx {"application/vnd.openxmlformats-officedocument.wordprocessingml.document"}

  static eot {"application/vnd.ms-fontobject"}
  static epub {"application/epub+zip"}
  static gz {"application/gzip"}
  static gif {"image/gif"}

  static html {"text/html"}
  static htmlUtf8 {"text/html; charset=utf-8"}

  static icon {"image/vnd.microsoft.icon"}
  static ics {"text/calendar"}
  static jar {"application/java-archive"}
  static jpeg {"image/jpeg"}
  static js {"text/javascript"}

  static json {"application/json"}
  static jsonUtf8 {"application/json; charset=utf-8"}
  static jsonld {"application/ld+json"}

  static midi {"audio/midi"}
  static mjs {"text/javascript"}
  static mp3 {"audio/mpeg"}
  static mpeg {"video/mpeg"}
  static mpkg {"application/vnd.apple.installer+xml"}
  static odp {"application/vnd.oasis.opendocument.presentation"}
  static ods {"application/vnd.oasis.opendocument.spreadsheet"}
  static odt {"application/vnd.oasis.opendocument.text"}
  static oga {"audio/ogg"}
  static ogv {"video/ogg"}
  static ogx {"application/ogg"}
  static opus {"audio/opus"}
  static otf {"font/otf"}
  static png {"image/png"}
  static pdf {"application/pdf"}
  static php {"application/x-httpd-php"}
  static ppt {"application/vnd.ms-powerpoint"}

  static pptx {"application/vnd.openxmlformats-officedocument.presentationml.presentation"}

  static rar {"application/vnd.rar"}
  static rtf {"application/rtf"}
  static sh  {"application/x-sh"}
  static svg {"image/svg+xml"}
  static swf {"application/x-shockwave-flash"}
  static tar {"application/x-tar"}
  static tiff {"image/tiff"}
  static ts {"video/mp2t"}
  static ttf {"font/ttf"}
  static txt {"text/plain"}
  static vsd {"application/vnd.visio"}
  static wav {"audio/wav"}
  static weba {"audio/webm"}
  static webm {"video/webm"}
  static webp {"image/webp"}

  static woff {"font/woff"}
  static woff2 {"font/woff2"}

  static xhtml {"application/xhtml+xml"}

  static xls {"application/vnd.ms-excel"}
  static xlsx {"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"}

  static xmlApp {"application/xml"}
  static xmlTxt {"text/xml"}

  static xul {"application/vnd.mozilla.xul+xml"}
  static zip {"application/zip"}

  static video3gp {"video/3gpp"}
  static audio3gp {"audio/3gpp"}
  static video3g2 {"video/3gpp2"}
  static audio3g2 {"audio/3gpp2"}

  static c7z {"application/x-7z-compressed"}
}
