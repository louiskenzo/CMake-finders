################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the GLib library (developer.gnome.org/glib)
# 
# Calling this finder will appropriately set the following CMake variables:
# - GLIB_FOUND, to a boolean value indicating if GLib headers and libraries were found;
# - GLIB_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - GLIB_LIBRARIES, to the path of the directory found to contain the binary library files;
# - GLIB_DEFINITIONS, to the compiler flags necessary when using GLib.

# Default library names
set(GLIB_LIBRARY_NAME glib-${GLib_FIND_VERSION_MAJOR}.${GLib_FIND_VERSION_MINOR})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find GLib
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_GLIB QUIET ${GLIB_LIBRARY_NAME})
	set(GLIB_DEFINITIONS ${PKGCONFIG_GLIB_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(GLIB_INCLUDE_HINTS ${PKGCONFIG_GLIB_INCLUDEDIR} ${PKGCONFIG_GLIB_INCLUDE_DIRS})
set(GLIB_LIBRARY_HINTS ${PKGCONFIG_GLIB_LIBDIR}     ${PKGCONFIG_GLIB_LIBRARY_DIRS})

# Search for the path to the root directory of the GLib header files
find_path(GLIB_INCLUDE_DIR
          NAMES glib.h
          HINTS ${GLIB_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${GLIB_LIBRARY_NAME})

# Search for the path to the config header files directory for GLib, which is situated under the library directory
find_path(GLIB_CONFIG_INCLUDE_DIR
          NAMES glibconfig.h
          HINTS ${GLIB_LIBRARY_HINTS}
                 /usr/lib
                 /usr/local/lib
                 /opt/local/lib
          PATH_SUFFIXES ${GLIB_LIBRARY_NAME}/include)

# Search for the path to the GLib library files
find_library(GLIB_LIBRARY
             NAMES ${GLIB_LIBRARY_NAME}
             HINTS ${GLIB_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(GLIB_LIBRARIES    ${GLIB_LIBRARY})
set(GLIB_INCLUDE_DIRS ${GLIB_INCLUDE_DIR};${GLIB_CONFIG_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set GLIB_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(GLib 
                                  DEFAULT_MSG
                                  GLIB_LIBRARY GLIB_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(GLIB_INCLUDE_DIR GLIB_LIBRARY)

################################################################################