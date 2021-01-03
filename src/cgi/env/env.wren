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

class Server {
  static name {Env.get("SERVER_NAME")}
  static protocol {Env.get("SERVER_PROTOCOL")}
  static software {Env.get("SERVER_SOFTWARE")}
  static port {Env.get("SERVER_PORT")}
  static address {Env.get("SERVER_ADDR")}
  static gateway {Env.get("GATEWAY_INTERFACE")}
  static script {Env.get("SCRIPT_NAME")}
  static path {Env.get("PATH")}
  static pathInfo {Env.get("PATH_INFO")}
  static pathTranslated {Env.get("PATH_TRANSLATED")}
  static signature {Env.get("SERVER_SIGNATURE")}
  static admin {Env.get("SERVER_ADMIN")}
  static prefix {Env.get("CONTEXT_PREFIX")}
  static documentRoot {Env.get("CONTEXT_DOCUMENT_ROOT")}
  static host {Env.get("HTTP_HOST")}

  static all {{
    "name": name,
    "protocol": protocol,
    "software": software,
    "port": port,
    "address": address,
    "gateway": gateway,
    "script": script,
    "pathInfo": pathInfo,
    "pathTranslated": pathTranslated,
    "signature": signature,
    "admin": admin,
    "prefix": prefix,
    "documentRoot": documentRoot,
    "host": host
  }}
}

class Request {
  static uri {Env.get("REQUEST_URI")}
  static method {Env.get("REQUEST_METHOD")}
  static auth {Env.get("AUTH_TYPE")}
  static type {Env.get("CONTENT_TYPE")}
  static length {Env.get("CONTENT_LENGTH")}
  static query {Env.get("QUERY_STRING")}
  static host {Env.get("REMOTE_HOST")}
  static port {Env.get("REMOTE_PORT")}
  static address {Env.get("REMOTE_ADDR")}
  static user {Env.get("REMOTE_USER")}
  static ident {Env.get("REMOTE_IDENT")}
  static accept {Env.get("HTTP_ACCEPT")}
  static agent {Env.get("HTTP_USER_AGENT")}
  static referer {Env.get("HTTP_REFERER")}
  static cookie {Env.get("HTTP_COOKIE")}
  static language {Env.get("HTTP_ACCEPT_LANGUAGE")}
  static scheme {Env.get("REQUEST_SCHEME")}
  static connection {Env.get("HTTP_CONNECTION")}
  static dnt {Env.get("HTTP_DNT")}
  static gpc {Env.get("HTTP_SEC_GPC")}
  static encoding {Env.get("HTTP_ACCEPT_ENCODING")}
  static upgrade {Env.get("HTTP_UPGRADE_INSECURE_REQUESTS")}

  static all {{
    "uri": uri,
    "method": method,
    "auth": auth,
    "type": type,
    "length": length,
    "query": query,
    "host": host,
    "address": address,
    "user": user,
    "ident": ident,
    "accept": accept,
    "referer": referer,
    "cookie": cookie,
    "language": language,
    "scheme": scheme,
    "connection": connection,
    "dnt": dnt,
    "gpc": gpc,
    "encoding": encoding,
    "upgrade": upgrade
  }}
}
