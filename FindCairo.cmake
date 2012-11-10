################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the Cairo library (www.cairographics.org)
# 
# Calling this finder will appropriately set the following CMake variables:
# - CAIRO_FOUND, to a boolean value indicating if Cairo headers and libraries were found;
# - CAIRO_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - CAIRO_LIBRARIES, to the path of the directory found to contain the binary library files;
# - CAIRO_DEFINITIONS, to the compiler flags necessary when using Cairo.

# Determine package name and dependent versions based on version
if (${Cairo_FIND_VERSION_MAJOR}.${Cairo_FIND_VERSION_MINOR} EQUAL 2.0)
  set(Freetype_VERSION 2)
endif ()

# Override parameters specific to platforms
if     (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # TODO
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # TODO
endif ()

# Search for dependencies
set(FIND_PACKAGE_ARGUMENTS)
if(CAIRO_FIND_QUIETLY)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS QUIET)
endif()
if(CAIRO_FIND_REQUIRED)
	set(FIND_PACKAGE_ARGUMENTS FIND_PACKAGE_ARGUMENTS REQUIRED)
endif()
find_package(Freetype ${Freetype_VERSION} ${FIND_PACKAGE_ARGUMENTS})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find Cairo
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_CAIRO QUIET cairo)
	set(CAIRO_DEFINITIONS ${PKGCONFIG_CAIRO_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(CAIRO_INCLUDE_HINTS ${PKGCONFIG_CAIRO_INCLUDEDIR} ${PKGCONFIG_CAIRO_INCLUDE_DIRS})
set(CAIRO_LIBRARY_HINTS ${PKGCONFIG_CAIRO_LIBDIR}     ${PKGCONFIG_CAIRO_LIBRARY_DIRS})

# Search for the path to the root directory of the Cairo header files
find_path(CAIRO_INCLUDE_DIR
	      NAMES cairo.h
          HINTS ${CAIRO_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES cairo)

# Search for the path to the Cairo library files
find_library(CAIRO_LIBRARY
             NAMES cairo
             HINTS ${CAIRO_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(CAIRO_LIBRARIES    ${CAIRO_LIBRARY};${FREETYPE_LIBRARIES})
set(CAIRO_INCLUDE_DIRS ${CAIRO_INCLUDE_DIR};${FREETYPE_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set CAIRO_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(Cairo 
                                  DEFAULT_MSG
                                  CAIRO_LIBRARY CAIRO_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(CAIRO_INCLUDE_DIR CAIRO_LIBRARY)

################################################################################