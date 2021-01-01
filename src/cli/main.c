#include <stdio.h>
#include <string.h>

#include "os.h"
#include "vm.h"
#include "wren.h"
#include "cgic.h"
#include "uv.h"
#include "version.h"

int showVersion() {
  printf("\\\\/\"-\n");
  printf(" \\_/\tWren CGI v%s\n", WRENCGI_VERSION_STRING);
  return 0;
}

int showVersionExtended() {
  showVersion();
  printf("Dependencies:\n");
  printf("\t- Wren: %s\n", WREN_VERSION_STRING);
  printf("\t- Cgic: %s\n", CGIC_VERSION_STRING);
  printf("\t- UV: %d.%d.%d\n", UV_VERSION_MAJOR, UV_VERSION_MINOR, UV_VERSION_PATCH);
  return 0;
}

int showHelp() {
  showVersion();
  printf("Usage: wren [file] [arguments...]\n");
  printf("\n");
  printf("Optional arguments:\n");
  printf("  --help     Show command line usage\n");
  printf("  --version  Show version\n");
  return 0;
}

// cgic.h implements main and call this.
int cgiMain(int argc, const char* argv[])
{
  if (argc == 2 && strcmp(argv[1], "--help") == 0)
  {
    return showHelp();
  }

  if (argc == 2 && strcmp(argv[1], "--version") == 0)
  {
    return showVersionExtended();
  }

  osSetArguments(argc, argv);

  WrenInterpretResult result;
  if (argc == 1)
  {
    result = runRepl();
  }
  else
  {
    result = runFile(argv[1]);
  }

  // Exit with an error code if the script failed.
  if (result == WREN_RESULT_COMPILE_ERROR) return 65; // EX_DATAERR.
  if (result == WREN_RESULT_RUNTIME_ERROR) return 70; // EX_SOFTWARE.

  return getExitCode();
}
