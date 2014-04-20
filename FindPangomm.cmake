################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

# CMake finder for the Pangomm library (developer.gnome.org/pangomm)
# 
# Calling this finder will appropriately set the following CMake variables:
# - PANGOMM_FOUND, to a boolean value indicating if Pangomm headers and libraries were found;
# - PANGOMM_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - PANGOMM_LIBRARIES, to the path of the directory found to contain the binary library files;
# - PANGOMM_DEFINITIONS, to the compiler flags necessary when using Pangomm.

# Default library names
set(PANGOMM_LIBRARY_NAME pangomm-${Pangomm_FIND_VERSION_MAJOR}.${Pangomm_FIND_VERSION_MINOR})

# Determine package name and dependent versions based on version
if (${Pangomm_FIND_VERSION_MAJOR}.${Pangomm_FIND_VERSION_MINOR} EQUAL 1.4)
  set(Pango_VERSION 1.0)
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # TODO
endif ()

# Search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(PANGOMM_FIND_QUIETLY)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(PANGOMM_FIND_REQUIRED)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(Pango ${Pango_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find Pangomm
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_PANGOMM QUIET ${PANGOMM_LIBRARY_NAME})
	set(PANGOMM_DEFINITIONS ${PKGCONFIG_PANGOMM_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(PANGOMM_INCLUDE_HINTS ${PKGCONFIG_PANGOMM_INCLUDEDIR} ${PKGCONFIG_PANGOMM_INCLUDE_DIRS})
set(PANGOMM_LIBRARY_HINTS ${PKGCONFIG_PANGOMM_LIBDIR}     ${PKGCONFIG_PANGOMM_LIBRARY_DIRS})

# Search for the path to the root directory of the Pangomm header files
find_path(PANGOMM_INCLUDE_DIR
          NAMES pangomm.h
          HINTS ${PANGOMM_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${PANGOMM_LIBRARY_NAME})

# Search for the path to the config header files directory for Pangomm, which is situated under the library directory
find_path(PANGOMM_CONFIG_INCLUDE_DIR
          NAMES pangommconfig.h
          HINTS ${PANGOMM_LIBRARY_HINTS}
                /usr/lib
                /usr/local/lib
                /opt/local/lib
          PATH_SUFFIXES ${PANGOMM_LIBRARY_NAME}/include)

# Search for the path to the Pangomm library files
find_library(PANGOMM_LIBRARY
             NAMES ${PANGOMM_LIBRARY_NAME}
             HINTS ${PANGOMM_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(PANGOMM_LIBRARIES    ${PANGOMM_LIBRARY};${PANGO_LIBRARIES})
set(PANGOMM_INCLUDE_DIRS ${PANGOMM_INCLUDE_DIR};${PANGOMM_CONFIG_INCLUDE_DIR};${PANGO_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set PANGOMM_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(Pangomm 
                                  DEFAULT_MSG
                                  PANGOMM_LIBRARY PANGOMM_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(PANGOMM_INCLUDE_DIR PANGOMM_LIBRARY)

################################################################################