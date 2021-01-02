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
extern void ENV_f_set(WrenVM * vm);
extern void ENV_f_remove(WrenVM * vm);

// get class
extern void GET_f_query(WrenVM * vm);


#define CGI_ENV_MODULES \
  MODULE(env) \
    CLASS(Env) \
      STATIC_METHOD("f_get(_)", ENV_f_get) \
      STATIC_METHOD("f_all", ENV_f_all) \
    END_CLASS \
    CLASS(Get) \
      STATIC_METHOD("f_query", GET_f_query) \
    END_CLASS \
  END_MODULE
#endif
