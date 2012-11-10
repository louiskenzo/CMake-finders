################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the Freetype library (www.freetype.org)
# 
# Calling this finder will appropriately set the following CMake variables:
# - FREETYPE_FOUND, to a boolean value indicating if Freetype headers and libraries were found;
# - FREETYPE_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - FREETYPE_LIBRARIES, to the path of the directory found to contain the binary library files;
# - FREETYPE_DEFINITIONS, to the compiler flags necessary when using Freetype.

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find Freetype
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_FREETYPE QUIET freetype)
	set(FREETYPE_DEFINITIONS ${PKGCONFIG_FREETYPE_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(FREETYPE_INCLUDE_HINTS ${PKGCONFIG_FREETYPE_INCLUDEDIR} ${PKGCONFIG_FREETYPE_INCLUDE_DIRS})
set(FREETYPE_LIBRARY_HINTS ${PKGCONFIG_FREETYPE_LIBDIR}     ${PKGCONFIG_FREETYPE_LIBRARY_DIRS})

# Search for the path to the root directory of the Freetype header files
find_path(FREETYPE_INCLUDE_DIR
          NAMES freetype/freetype.h
          HINTS ${FREETYPE_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES freetype${Freetype_FIND_VERSION_MAJOR})

# Search for the path to the Freetype library files
find_library(FREETYPE_LIBRARY
             NAMES freetype
             HINTS ${FREETYPE_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(FREETYPE_LIBRARIES    ${FREETYPE_LIBRARY})
set(FREETYPE_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set FREETYPE_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(Freetype 
	                              DEFAULT_MSG
                                  FREETYPE_LIBRARY FREETYPE_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(FREETYPE_INCLUDE_DIR FREETYPE_LIBRARY)

################################################################################