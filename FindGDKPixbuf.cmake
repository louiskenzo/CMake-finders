################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

# CMake finder for the GDKPixbuf library (http://developer.gnome.org/gdk-pixbuf)
# 
# Calling this finder will appropriately set the following CMake variables:
# - GDKPIXBUF_FOUND, to a boolean value indicating if GDKPixbuf headers and libraries were found;
# - GDKPIXBUF_INCLUDE_DIRS, to the path of the directory found to contain the header files;
# - GDKPIXBUF_LIBRARIES, to the path of the directory found to contain the binary library files;
# - GDKPIXBUF_DEFINITIONS, to the compiler flags necessary when using GDKPixbuf.

# Default library names
set(GDKPIXBUF_LIBRARY_NAME gdk-pixbuf-${GDKPixbuf_FIND_VERSION_MAJOR}.${GDKPixbuf_FIND_VERSION_MINOR})
set(GDKPIXBUF_LIBRARY_FILE gdk_pixbuf-${GDKPixbuf_FIND_VERSION_MAJOR}.${GDKPixbuf_FIND_VERSION_MINOR})

# Under Unix systems -including Linux, OSX, and Cygwin- try using pkg-config to find GDKPixbuf
find_package(PkgConfig)
if (PKG_CONFIG_FOUND)
	pkg_check_modules(PKGCONFIG_GDKPixbuf QUIET ${GDKPIXBUF_LIBRARY_NAME})
	set(GDKPIXBUF_DEFINITIONS ${PKGCONFIG_GDKPIXBUF_CFLAGS_OTHER})
endif (PKG_CONFIG_FOUND)

# Extract the needed variables
set(GDKPIXBUF_INCLUDE_HINTS ${PKGCONFIG_GDKPIXBUF_INCLUDEDIR} ${PKGCONFIG_GDKPIXBUF_INCLUDE_DIRS})
set(GDKPIXBUF_LIBRARY_HINTS ${PKGCONFIG_GDKPIXBUF_LIBDIR}     ${PKGCONFIG_GDKPIXBUF_LIBRARY_DIRS})

# Search for the path to the root directory of the GDKPixbuf header files
find_path(GDKPIXBUF_INCLUDE_DIR
          NAMES gdk-pixbuf/gdk-pixbuf.h
          HINTS ${GDKPIXBUF_INCLUDE_HINTS}
                /usr/include
                /usr/local/include
                /opt/local/include
          PATH_SUFFIXES ${GDKPIXBUF_LIBRARY_NAME})

# Search for the path to the GDKPixbuf library files
find_library(GDKPIXBUF_LIBRARY
             NAMES ${GDKPIXBUF_LIBRARY_FILE}
             HINTS ${GDKPIXBUF_LIBRARY_HINTS}
                   /usr/lib
                   /usr/local/lib
                   /opt/local/lib)

# Set the plural forms of the variables as is the convention
set(GDKPIXBUF_LIBRARIES    ${GDKPIXBUF_LIBRARY})
set(GDKPIXBUF_INCLUDE_DIRS ${GDKPIXBUF_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
# Handle the QUIETLY and REQUIRED arguments and set GDKPIXBUF_FOUND to TRUE if all listed variables are TRUE
find_package_handle_standard_args(GDKPixbuf 
                                  DEFAULT_MSG
                                  GDKPIXBUF_LIBRARY GDKPIXBUF_INCLUDE_DIR)

# Mark the singular variables as advanced, to hide them of the GUI by default
mark_as_advanced(GDKPIXBUF_INCLUDE_DIR GDKPIXBUF_LIBRARY)

################################################################################