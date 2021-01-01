// Generated automatically from ./src/cgi/env.wren. Do not edit.
static const char* envModuleSource =
"\n"
"class Env {\n"
"  // Segmentation fault if pass null\n"
"  // so a wrapper is needed for public api\n"
"  foreign static f_get(name)\n"
"  static get(name) {\n"
"    if (name is String && name.count > 0) {\n"
"      return f_get(name)\n"
"    }\n"
"    return \"\"\n"
"  }\n"
"}\n";
