#ifndef response_h
#define response_h

#include "wren.h"
#include "registry.h"

// response.wren
#include "response.wren.inc"

#define CGI_RESPONSE_MODULES \
  MODULE(response) \
    CLASS(Response) \
    END_CLASS \
    CLASS(Headers) \
    END_CLASS \
  END_MODULE

#endif
