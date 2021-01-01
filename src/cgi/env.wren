
class Env {
  // Segmentation fault if pass null
  // so a wrapper is needed for public api
  foreign static f_get(name)
  static get(name) {
    if (name is String && name.count > 0) {
      return f_get(name)
    }
    return ""
  }
}
