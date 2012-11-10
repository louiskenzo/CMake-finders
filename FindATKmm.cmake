################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the ATKmm library (developer.gnome.org/atkmm)
# 
# Calling this finder will appropriately set the following CMake variables:
# - ATKMM_FOUND, to a boolean value indicating if ATKmm headers and libraries were found;
# - ATKMM_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - ATKMM_LIBRARIES, to the path of the directory found to contain the binary library files;
# - ATKMM_DEFINITIONS, to the compiler flags necessary when using ATKmm.

# Default library names
set(ATKMM_LIBRARY_NAME atkmm-${ATKmm_FIND_VERSION_MAJOR}.${ATKmm_FIND_VERSION_MINOR})

# Determine package name and dependent versions based on version
if (${ATKmm_FIND_VERSION_MAJOR}.${ATKmm_FIND_VERSION_MINOR} EQUAL 1.6)
  set(ATK_VERSION 1.0)
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # TODO
endif ()

# Search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(ATKMM_FIND_QUIETLY)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(ATKMM_FIND_REQUIRED)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(ATK ${ATK_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find ATKmm
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_ATKMM QUIET ${ATKMM_LIBRARY_NAME})
	set(ATKMM_DEFINITIONS ${PKGCONFIG_ATKMM_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(ATKMM_INCLUDE_HINTS ${PKGCONFIG_ATKMM_INCLUDEDIR} ${PKGCONFIG_ATKMM_INCLUDE_DIRS})
set(ATKMM_LIBRARY_HINTS ${PKGCONFIG_ATKMM_LIBDIR}     ${PKGCONFIG_ATKMM_LIBRARY_DIRS})

# Search for the path to the root directory of the ATKmm header files
find_path(ATKMM_INCLUDE_DIR
          NAMES atkmm.h
          HINTS ${ATKMM_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${ATKMM_LIBRARY_NAME})

# Search for the path to the config header files directory for ATKmm, which is situated under the library directory
find_path(ATKMM_CONFIG_INCLUDE_DIR
          NAMES atkmmconfig.h
          HINTS ${ATKMM_LIBRARY_HINTS}
                /usr/lib
                /usr/local/lib
                /opt/local/lib
          PATH_SUFFIXES ${ATKMM_LIBRARY_NAME}/include)

# Search for the path to the ATKmm library files
find_library(ATKMM_LIBRARY
             NAMES ${ATKMM_LIBRARY_NAME}
             HINTS ${ATKMM_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(ATKMM_LIBRARIES    ${ATKMM_LIBRARY};${ATK_LIBRARIES})
set(ATKMM_INCLUDE_DIRS ${ATKMM_INCLUDE_DIR};${ATKMM_CONFIG_INCLUDE_DIRS};${ATK_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set ATKMM_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(ATKmm 
                                  DEFAULT_MSG
                                  ATKMM_LIBRARY ATKMM_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(ATKMM_INCLUDE_DIR ATKMM_LIBRARY)

################################################################################