find_path2(LIBVTERM_INCLUDE_DIR vterm.h)
find_library2(LIBVTERM_LIBRARY vterm)

if(LIBVTERM_INCLUDE_DIR AND EXISTS "${LIBVTERM_INCLUDE_DIR}/vterm.h")
  file(STRINGS ${LIBVTERM_INCLUDE_DIR}/vterm.h VTERM_VERSION_MAJOR REGEX "#define VTERM_VERSION_MAJOR")
  string(REGEX MATCH "[0-9]+" VTERM_VERSION_MAJOR ${VTERM_VERSION_MAJOR})

  file(STRINGS ${LIBVTERM_INCLUDE_DIR}/vterm.h VTERM_VERSION_MINOR REGEX "#define VTERM_VERSION_MINOR")
  string(REGEX MATCH "[0-9]+" VTERM_VERSION_MINOR ${VTERM_VERSION_MINOR})

  file(STRINGS ${LIBVTERM_INCLUDE_DIR}/vterm.h VTERM_VERSION_PATCH REGEX "#define VTERM_VERSION_PATCH")

  # The following is needed to give a coherent error for versions 0.3.2 and
  # smaller.
  if(VTERM_VERSION_PATCH)
    string(REGEX MATCH "[0-9]+" VTERM_VERSION_PATCH ${VTERM_VERSION_PATCH})
    string(PREPEND VTERM_VERSION_PATCH ".")
  endif()

  set(VTERM_VERSION ${VTERM_VERSION_MAJOR}.${VTERM_VERSION_MINOR}${VTERM_VERSION_PATCH})
endif()

find_package_handle_standard_args(Libvterm
  REQUIRED_VARS LIBVTERM_INCLUDE_DIR LIBVTERM_LIBRARY
  VERSION_VAR VTERM_VERSION)

add_library(libvterm INTERFACE)
target_include_directories(libvterm SYSTEM BEFORE INTERFACE ${LIBVTERM_INCLUDE_DIR})
target_link_libraries(libvterm INTERFACE ${LIBVTERM_LIBRARY})

mark_as_advanced(LIBVTERM_INCLUDE_DIR LIBVTERM_LIBRARY)