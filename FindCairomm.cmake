################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the Cairomm library (cairographics.org/cairomm)
# 
# Calling this finder will appropriately set the following CMake variables:
# - CAIROMM_FOUND, to a boolean value indicating if Cairomm headers and libraries were found;
# - CAIROMM_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - CAIROMM_LIBRARIES, to the path of the directory found to contain the binary library files;
# - CAIROMM_DEFINITIONS, to the compiler flags necessary when using Cairomm.

# Default library names
set(CAIROMM_LIBRARY_NAME cairomm-${Cairomm_FIND_VERSION_MAJOR}.${Cairomm_FIND_VERSION_MINOR})

# Determine package name and dependent versions based on version
if (${Cairomm_FIND_VERSION_MAJOR}.${Cairomm_FIND_VERSION_MINOR} EQUAL 1.0)
  set(Cairo_VERSION 2.0)
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # TODO
endif ()

# Search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(CAIROMM_FIND_QUIETLY)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(CAIROMM_FIND_REQUIRED)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(Cairo ${Cairo_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find Cairomm
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_CAIROMM QUIET ${CAIROMM_LIBRARY_NAME})
	set(CAIROMM_DEFINITIONS ${PKGCONFIG_CAIROMM_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(CAIROMM_INCLUDE_HINTS ${PKGCONFIG_CAIROMM_INCLUDEDIR} ${PKGCONFIG_CAIROMM_INCLUDE_DIRS})
set(CAIROMM_LIBRARY_HINTS ${PKGCONFIG_CAIROMM_LIBDIR}     ${PKGCONFIG_CAIROMM_LIBRARY_DIRS})

# Search for the path to the root directory of the Cairomm header files
find_path(CAIROMM_INCLUDE_DIR
          NAMES cairomm/cairomm.h
          HINTS ${CAIROMM_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${CAIROMM_LIBRARY_NAME})

# Search for the path to the config header files directory for Cairomm, which is situated under the library directory
find_path(CAIROMM_CONFIG_INCLUDE_DIR
          NAMES cairommconfig.h
          HINTS ${CAIROMM_LIBRARY_HINTS}
                /usr/lib
                /usr/local/lib
                /opt/local/lib
          PATH_SUFFIXES ${CAIROMM_LIBRARY_NAME}/include)

# Search for the path to the Cairomm library files
find_library(CAIROMM_LIBRARY
             NAMES ${CAIROMM_LIBRARY_NAME}
             HINTS ${CAIROMM_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(CAIROMM_LIBRARIES    ${CAIROMM_LIBRARY};${CAIRO_LIBRARIES})
set(CAIROMM_INCLUDE_DIRS ${CAIROMM_INCLUDE_DIR};${CAIROMM_CONFIG_INCLUDE_DIR}:${CAIRO_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set CAIROMM_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(Cairomm 
                                  DEFAULT_MSG
                                  CAIROMM_LIBRARY CAIROMM_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(CAIROMM_INCLUDE_DIR CAIROMM_LIBRARY)

################################################################################