// The Wren CGI semantic version number components.
#define WRENCGI_VERSION_MAJOR 1
#define WRENCGI_VERSION_MINOR 0
#define WRENCGI_VERSION_PATCH 0

// A human-friendly string representation of the version.
#define WRENCGI_VERSION_STRING "1.0.0"

// A monotonically increasing numeric representation of the version number. Use
// this if you want to do range checks over versions.
#define WRENCGI_VERSION_NUMBER (WRENCGI_VERSION_MAJOR * 1000000 + \
                             WRENCGI_VERSION_MINOR * 1000 + \
                             WRENCGI_VERSION_PATCH)
