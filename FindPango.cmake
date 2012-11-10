################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the Pango library (www.pango.org)
# 
# Calling this finder will appropriately set the following CMake variables:
# - PANGO_FOUND, to a boolean value indicating if Pango headers and libraries were found;
# - PANGO_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - PANGO_LIBRARIES, to the path of the directory found to contain the binary library files;
# - PANGO_DEFINITIONS, to the compiler flags necessary when using Pango.

# Default library names
set(PANGO_LIBRARY_NAME    pango-${Pango_FIND_VERSION_MAJOR}.${Pango_FIND_VERSION_MINOR})
set(PANGO_PKG_CONFIG_NAME pango)

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find Pango
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_PANGO QUIET ${PANGO_LIBRARY_NAME})
	set(PANGO_DEFINITIONS ${PKGCONFIG_PANGO_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(PANGO_INCLUDE_HINTS ${PKGCONFIG_PANGO_INCLUDEDIR} ${PKGCONFIG_PANGO_INCLUDE_DIRS})
set(PANGO_LIBRARY_HINTS ${PKGCONFIG_PANGO_LIBDIR}     ${PKGCONFIG_PANGO_LIBRARY_DIRS})

# Search for the path to the root directory of the Pango header files
find_path(PANGO_INCLUDE_DIR
          NAMES pango/pango.h
          HINTS ${PANGO_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${PANGO_LIBRARY_NAME})

# Search for the path to the Pango library files
find_library(PANGO_LIBRARY
             NAMES ${PANGO_LIBRARY_NAME}
             HINTS ${PANGO_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(PANGO_LIBRARIES    ${PANGO_LIBRARY})
set(PANGO_INCLUDE_DIRS ${PANGO_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set PANGO_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(Pango 
                                  DEFAULT_MSG
                                  PANGO_LIBRARY PANGO_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(PANGO_INCLUDE_DIR PANGO_LIBRARY)

################################################################################