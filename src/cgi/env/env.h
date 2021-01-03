#ifndef env_h
#define env_h

#include "wren.h"
#include "registry.h"

// env.wren
#include "env.wren.inc"

extern void ENV_f_get(WrenVM * vm);
extern void ENV_f_all(WrenVM * vm);

// Setting and removing ENV vars from the client
// can be dangerous
// read http://php.kambing.ui.ac.id/manual/en/function.putenv.php
// its best to have an allowed list first to determine
// which variables can be updated/removed
// extern void ENV_f_set(WrenVM * vm);
// extern void ENV_f_remove(WrenVM * vm);

extern void REQUEST_f_content_type(WrenVM * vm);
extern void REQUEST_f_content_length(WrenVM * vm);

#define CGI_ENV_MODULES \
  MODULE(env) \
    CLASS(Env) \
      STATIC_METHOD("f_get(_)", ENV_f_get) \
      STATIC_METHOD("f_all", ENV_f_all) \
    END_CLASS \
    CLASS(Request) \
      STATIC_METHOD("f_content_type", REQUEST_f_content_type) \
      STATIC_METHOD("f_content_length", REQUEST_f_content_type) \
    END_CLASS \
    CLASS(Server) \
    END_CLASS \
  END_MODULE
#endif
