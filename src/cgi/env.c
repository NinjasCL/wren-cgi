#include "wren.h"
#include "cgic.h"
#include "uv.h"

#define ENV_DEFAULT_BUFFER 1024

// http://docs.libuv.org/en/v1.x/misc.html#c.uv_os_getenv
// Env.f_get(name)
void ENV_f_get(WrenVM * vm) {
  wrenEnsureSlots(vm, 1);
  const char* name = wrenGetSlotString(vm, 1);

  char _buffer[ENV_DEFAULT_BUFFER];
  char* buffer = _buffer;
  size_t length = sizeof(_buffer);
  int result = uv_os_getenv(name, buffer, &length);

  if (result == UV_ENOBUFS) {
    buffer = (char*)malloc(length);
    result = uv_os_getenv(name, buffer, &length);
  }

  if (result != 0) {
    wrenSetSlotString(vm, 0, "Cannot get the environment variable.");
    wrenAbortFiber(vm, 0);
    return;
  }

  wrenSetSlotString(vm, 0, buffer);

  // If the final buffer required more than the default
  // free the memory
  if (buffer != _buffer) {
    free(buffer);
  }
}

void ENV_f_all(WrenVM * vm) {

  uv_env_item_t _buffer[ENV_DEFAULT_BUFFER];
  uv_env_item_t * buffer = _buffer;
  int size = sizeof(_buffer);

  int result = uv_os_environ(&buffer, &size);
  if (result == UV_ENOMEM) {
    buffer = (uv_env_item_t *) malloc(size);
    result = uv_os_environ(&buffer, &size);
  }

  if (result != 0) {
    wrenEnsureSlots(vm, 1);
    wrenSetSlotString(vm, 0, "Cannot get the environment variables.");
    wrenAbortFiber(vm, 0);
    return;
  }

  // Return the list of names
  // Since wren map API is available only in Wren >= 0.4.0
  uv_env_item_t * item;

  wrenEnsureSlots(vm, 2);
  wrenSetSlotNewList(vm, 0);

  for (int i = 0; i < size; i++) {
    item = &buffer[i];
    wrenSetSlotString(vm, 1, item->name);
    wrenInsertInList(vm, 0, -1, 1);
  }

  uv_os_free_environ(buffer, size);
}
