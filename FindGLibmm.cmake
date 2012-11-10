################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the GLibmm library (developer.gnome.org/glibmm)
# 
# Calling this finder will appropriately set the following CMake variables:
# - GLIBMM_FOUND, to a boolean value indicating if GLibmm headers and libraries were found;
# - GLIBMM_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - GLIBMM_LIBRARIES, to the path of the directory found to contain the binary library files;
# - GLIBMM_DEFINITIONS, to the compiler flags necessary when using GLibmm.

# Default library names
set(GLIBMM_LIBRARY_NAME glibmm-${GLibmm_FIND_VERSION_MAJOR}.${GLibmm_FIND_VERSION_MINOR})
set( GIOMM_LIBRARY_NAME  giomm-${GLibmm_FIND_VERSION_MAJOR}.${GLibmm_FIND_VERSION_MINOR})

# Determine package name and dependent versions based on version
if (${GLibmm_FIND_VERSION_MAJOR}.${GLibmm_FIND_VERSION_MINOR} EQUAL 2.4)
  set(  GLib_VERSION 2.0)
  set(sigc++_VERSION 2.0)
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # TODO
endif ()

# Search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(GLIBMM_FIND_QUIETLY)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(GLIBMM_FIND_REQUIRED)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(GLib     ${GLib_VERSION} ${FIND_PACKAGE_ARGUMENTS})
find_package(sigc++ ${sigc++_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find GLibmm, GIOmm and GDKmm
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_GLIBMM QUIET ${GLIBMM_LIBRARY_NAME})
  pkg_check_modules(PKGCONFIG_GIOMM  QUIET  ${GIOMM_LIBRARY_NAME})

  set(GLIBMM_DEFINITIONS ${PKGCONFIG_GLIBMM_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(GLIBMM_INCLUDE_HINTS ${PKGCONFIG_GLIBMM_INCLUDEDIR} ${PKGCONFIG_GLIBMM_INCLUDE_DIRS})
set(GLIBMM_LIBRARY_HINTS ${PKGCONFIG_GLIBMM_LIBDIR}     ${PKGCONFIG_GLIBMM_LIBRARY_DIRS})
set( GIOMM_INCLUDE_HINTS ${PKGCONFIG_GIOMM_INCLUDEDIR}  ${PKGCONFIG_GIOMM_INCLUDE_DIRS})
set( GIOMM_LIBRARY_HINTS ${PKGCONFIG_GIOMM_LIBDIR}      ${PKGCONFIG_GIOMM_LIBRARY_DIRS})

# Search for the path to the root directory of the GLibmm header files
find_path(GLIBMM_INCLUDE_DIR
          NAMES glibmm.h
          HINTS ${GLIBMM_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${GLIBMM_LIBRARY_NAME})

# Search for the path to the config header files directory for GLibmm, which is situated under the library directory
find_path(GLIBMM_CONFIG_INCLUDE_DIR
          NAMES glibmmconfig.h
          HINTS ${GLIBMM_LIBRARY_HINTS}
                 /usr/lib
                 /usr/local/lib
                 /opt/local/lib
          PATH_SUFFIXES ${GLIBMM_LIBRARY_NAME}/include)

# Search for the path to the GLibmm library files
find_library(GLIBMM_LIBRARY
             NAMES ${GLIBMM_LIBRARY_NAME}
             HINTS ${GLIBMM_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Search for the path to the root directory of the GIOmm header files
find_path(GIOMM_INCLUDE_DIR
          NAMES giomm.h
          HINTS ${GIOMM_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${GIOMM_LIBRARY_NAME})

# Search for the path to the GIOmm library files
find_library(GIOMM_LIBRARY
             NAMES ${GIOMM_LIBRARY_NAME}
             HINTS ${GIOMM_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(GLIBMM_LIBRARIES    ${GLIBMM_LIBRARY};${GIOMM_LIBRARY};${GLIB_LIBRARIES};${SIGC++_LIBRARIES})
set(GLIBMM_INCLUDE_DIRS ${GLIBMM_INCLUDE_DIR};${GLIBMM_CONFIG_INCLUDE_DIR};${GIOMM_INCLUDE_DIR};${GLIB_INCLUDE_DIRS};${SIGC++_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set GLIBMM_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(GLibmm 
                                  DEFAULT_MSG
                                  GLIBMM_LIBRARY GLIBMM_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(GLIBMM_INCLUDE_DIR GLIBMM_LIBRARY)

################################################################################