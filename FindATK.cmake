################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

# CMake finder for the ATK library (developer.gnome.org/atk)
# 
# Calling this finder will appropriately set the following CMake variables:
# - ATK_FOUND, to a boolean value indicating if ATK headers and libraries were found;
# - ATK_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - ATK_LIBRARIES, to the path of the directory found to contain the binary library files;
# - ATK_DEFINITIONS, to the compiler flags necessary when using ATK.

# Default library names
set(ATK_LIBRARY_NAME atk-${ATK_FIND_VERSION_MAJOR}.${ATK_FIND_VERSION_MINOR})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find ATK
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_ATK QUIET ${ATK_LIBRARY_NAME})
	set(ATK_DEFINITIONS ${PKGCONFIG_ATK_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(ATK_INCLUDE_HINTS ${PKGCONFIG_ATK_INCLUDEDIR} ${PKGCONFIG_ATK_INCLUDE_DIRS})
set(ATK_LIBRARY_HINTS ${PKGCONFIG_ATK_LIBDIR}     ${PKGCONFIG_ATK_LIBRARY_DIRS})

# Search for the path to the root directory of the ATK header files
find_path(ATK_INCLUDE_DIR
	      NAMES atk/atk.h
          HINTS ${ATK_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${ATK_LIBRARY_NAME})

# Search for the path to the ATK library files
find_library(ATK_LIBRARY
             NAMES ${ATK_LIBRARY_NAME}
             HINTS ${ATK_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(ATK_LIBRARIES    ${ATK_LIBRARY})
set(ATK_INCLUDE_DIRS ${ATK_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set ATK_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(ATK 
	                              DEFAULT_MSG
                                  ATK_LIBRARY ATK_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(ATK_INCLUDE_DIR ATK_LIBRARY)

################################################################################