################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

# CMake finder for the sigc++ library (http://libsigc.sourceforge.net/)
# 
# Calling this finder will appropriately set the following CMake variables:
# - SIGC++_FOUND, to a boolean value indicating if sigc++ headers and libraries were found;
# - SIGC++_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - SIGC++_LIBRARIES, to the path of the directory found to contain the binary library files;
# - SIGC++_DEFINITIONS, to the compiler flags necessary when using sigc++.

# Default library names
set(SIGC++_LIBRARY_NAME sigc++-${sigc++_FIND_VERSION_MAJOR}.${sigc++_FIND_VERSION_MINOR})
set(SIGC++_LIBRARY_FILE sigc-${sigc++_FIND_VERSION_MAJOR}.${sigc++_FIND_VERSION_MINOR})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find sigc++
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_SIGC++ QUIET ${SIGC++_LIBRARY_NAME})
	set(SIGC++_DEFINITIONS ${PKGCONFIG_SIGC++_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(SIGC++_INCLUDE_HINTS ${PKGCONFIG_SIGC++_INCLUDEDIR} ${PKGCONFIG_SIGC++_INCLUDE_DIRS})
set(SIGC++_LIBRARY_HINTS ${PKGCONFIG_SIGC++_LIBDIR}     ${PKGCONFIG_SIGC++_LIBRARY_DIRS})

# Search for the path to the root directory of the sigc++ header files
find_path(SIGC++_INCLUDE_DIR
          NAMES sigc++/sigc++.h
          HINTS ${SIGC++_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${SIGC++_LIBRARY_NAME})

# Search for the path to the config header files directory for sigc++, which is situated under the library directory
find_path(SIGC++_CONFIG_INCLUDE_DIR
          NAMES sigc++config.h
          HINTS ${SIGC++_LIBRARY_HINTS}
                 /usr/lib
                 /usr/local/lib
                 /opt/local/lib
          PATH_SUFFIXES ${SIGC++_LIBRARY_NAME}/include)

# Search for the path to the sigc++ library files
find_library(SIGC++_LIBRARY
             NAMES ${SIGC++_LIBRARY_FILE}
             HINTS $${SIGC++_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(SIGC++_LIBRARIES    ${SIGC++_LIBRARY})
set(SIGC++_INCLUDE_DIRS ${SIGC++_INCLUDE_DIR};${SIGC++_CONFIG_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set SIGC++_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(sigc++ 
                                  DEFAULT_MSG
                                  SIGC++_LIBRARY SIGC++_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(SIGC++_INCLUDE_DIR SIGC++_LIBRARY)

################################################################################