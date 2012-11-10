################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the GTKGLExtmm library (projects.gnome.org/gtkglext)
# 
# Calling this finder will appropriately set the following CMake variables:
# - GTKGLEXTMM_FOUND, to a boolean value indicating if GTKGLExtmm headers and libraries were found;
# - GTKGLEXTMM_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - GTKGLEXTMM_LIBRARIES, to the path of the directory found to contain the binary library files;
# - GTKGLEXTMM_DEFINITIONS, to the compiler flags necessary when using GTKGLExtmm.

# Default library names
set(GTKGLEXTMM_LIBRARY_NAME gtkglextmm-x11-${GTKGLExtmm_FIND_VERSION_MAJOR}.${GTKGLExtmm_FIND_VERSION_MINOR})

# Determine package name and dependent versions based on version
if (${GTKmm_FIND_VERSION_MAJOR}.${GTKmm_FIND_VERSION_MINOR} EQUAL 1.2)
	set(GTKMM_VERSION 3.0)
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
	# TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
	# TODO
endif ()

# Forward search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(GTKGLEXTMM_FIND_QUIETLY)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(GTKGLEXTMM_FIND_REQUIRED)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(GTKmm ${GTKMM_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find GTKGLExtmm
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_GTKGLEXTMM QUIET ${GTKGLEXTMM_LIBRARY_NAME})
	set(GTKGLEXTMM_DEFINITIONS ${PKGCONFIG_GTKGLEXTMM_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(GTKGLEXTMM_INCLUDE_HINTS ${PKGCONFIG_GTKGLEXTMM_INCLUDEDIR} ${PKGCONFIG_GTKGLEXTMM_INCLUDE_DIRS})
set(GTKGLEXTMM_LIBRARY_HINTS ${PKGCONFIG_GTKGLEXTMM_LIBDIR} ${PKGCONFIG_GTKGLEXTMM_LIBRARY_DIRS})

# Search for the path to the root directory of the GTKGLExtmm header files
find_path(GTKGLEXTMM_INCLUDE_DIR
          NAMES gtkglmm.h
          HINTS ${GTKGLEXTMM_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES gtkglextmm-${PACKAGE_FIND_VERSION_MAJOR}.${PACKAGE_FIND_VERSION_MINOR})

# Search for the path to the GTKGLExtmm library files
find_library(GTKGLEXTMM_LIBRARY
             NAMES ${GTKGLEXTMM_LIBRARY_NAME}
             HINTS ${GTKGLEXTMM_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(GTKGLEXTMM_LIBRARIES    ${GTKGLEXTMM_LIBRARY};${GTKMM_LIBRARIES})
set(GTKGLEXTMM_INCLUDE_DIRS ${GTKGLEXTMM_INCLUDE_DIR};${GTKMM_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set GTKGLEXTMM_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(GTKGLExtmm 
                                  DEFAULT_MSG
                                  GTKGLEXTMM_LIBRARY GTKGLEXTMM_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(GTKGLEXTMM_INCLUDE_DIR GTKGLEXTMM_LIBRARY)

################################################################################