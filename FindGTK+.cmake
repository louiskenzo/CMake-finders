################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

# CMake finder for the GTK+ library (www.gtk.rg)
# 
# Calling this finder will appropriately set the following CMake variables:
# - GTK+_FOUND, to a boolean value indicating if GTK+ headers and libraries were found;
# - GTK+_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - GTK+_LIBRARIES, to the path of the directory found to contain the binary library files;
# - GTK+_DEFINITIONS, to the compiler flags necessary when using GTK+.

# Default library names
set(GTK+_LIBRARY_NAME    gtk-${GTK+_FIND_VERSION_MAJOR}.${GTK+_FIND_VERSION_MINOR})
set(GTK+_PKG_CONFIG_NAME gtk+-${GTK+_FIND_VERSION_MAJOR}.${GTK+_FIND_VERSION_MINOR})
set(GTK+_LIBRARY_FILE    gtk-${GTK+_FIND_VERSION_MAJOR}.${GTK+_FIND_VERSION_MINOR}) # For when the so file has a different name than the meta package name

# Determine package name and dependent versions based on version
if (${GTK+_FIND_VERSION_MAJOR}.${GTK+_FIND_VERSION_MINOR} EQUAL 3.0)
  set(    Pango_VERSION 1.0)
  set(GDKPixbuf_VERSION 2.0)
  set(      ATK_VERSION 1.0)
  set(    CAIRO_VERSION 2.0)
  set(GTK+_LIBRARY_FILE gtk-${GTK+_FIND_VERSION_MAJOR})
elseif (${GTK+_FIND_VERSION_MAJOR}.${GTK+_FIND_VERSION_MINOR} EQUAL 2.0)
  set(    Pango_VERSION 1.0)
  set(GDKPixbuf_VERSION 2.0)
  set(      ATK_VERSION 1.0)
  set(    CAIRO_VERSION 2.0)
  set(GTK+_LIBRARY_FILE gtk-x11-${GTK+_FIND_VERSION_MAJOR}.${GTK+_FIND_VERSION_MINOR})
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # TODO
endif ()

# Search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(GTK+_FIND_QUIETLY)
  set(LFIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(GTK+_FIND_REQUIRED)
  set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(Pango         ${Pango_VERSION} ${FIND_PACKAGE_ARGUMENTS})
find_package(GDKPixbuf ${GDKPixbuf_VERSION} ${FIND_PACKAGE_ARGUMENTS})
find_package(ATK             ${ATK_VERSION} ${FIND_PACKAGE_ARGUMENTS})
find_package(Cairo         ${CAIRO_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find GTK+
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
  pkg_check_modules(PKGCONFIG_GTK+ QUIET ${GTK+_PKG_CONFIG_NAME})
  set(GTK+_DEFINITIONS ${PKGCONFIG_GTK+_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(GTK+_INCLUDE_HINTS ${PKGCONFIG_GTK+_INCLUDEDIR} ${PKGCONFIG_GTK+_INCLUDE_DIRS})
set(GTK+_LIBRARY_HINTS ${PKGCONFIG_GTK+_LIBDIR} ${PKGCONFIG_GTK+_LIBRARY_DIRS})

# Search for the path to the root directory of the GTK+ header files
find_path(GTK+_INCLUDE_DIR
          NAMES gtk/gtk.h
          HINTS ${GTK+_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${GTK+_LIBRARY_NAME})

# Search for the path to the config header files directory for GLibmm, which is situated under the library directory
find_path(GDK_CONFIG_INCLUDE_DIR
          NAMES gdkconfig.h
          HINTS ${GTK+_LIBRARY_HINTS}
                /usr/lib
                /usr/local/lib
                /opt/local/lib
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${GTK+_LIBRARY_NAME}/include
                        ${GTK+_LIBRARY_NAME}/gdk)

# Search for the path to the GTK+ library files
find_library(GTK+_LIBRARY
             NAMES ${GTK+_LIBRARY_FILE}
             HINTS ${PKGCONFIG_GTK+_LIBDIR}
                   ${PKGCONFIG_GTK+_LIBRARY_DIRS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(GTK+_LIBRARIES    ${GTK+_LIBRARY};${PANGO_LIBRARIES};${GDKPIXBUF_LIBRARIES};${ATK_LIBRARIES};${CAIRO_LIBRARIES})
set(GTK+_INCLUDE_DIRS ${GTK+_INCLUDE_DIR};${GDK_CONFIG_INCLUDE_DIR};${PANGO_INCLUDE_DIRS};${GDKPIXBUF_INCLUDE_DIRS};${ATK_INCLUDE_DIRS};${CAIRO_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set GTK+_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(GTK+ 
                                  DEFAULT_MSG
                                  GTK+_LIBRARY GTK+_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(GTK+_INCLUDE_DIR GTK+_LIBRARY)

################################################################################