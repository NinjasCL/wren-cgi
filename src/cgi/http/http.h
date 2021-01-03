#ifndef http_h
#define http_h

#include "wren.h"
#include "registry.h"

#include "http.wren.inc"

#define CGI_HTTP_MODULES \
  MODULE(http) \
    CLASS(Response) \
    END_CLASS \
    CLASS(Headers) \
    END_CLASS \
    CLASS(Status) \
    END_CLASS \
  END_MODULE

#endif
