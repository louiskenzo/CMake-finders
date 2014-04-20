################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

#Find the path to the headers
find_path(libssh2_INCLUDE_DIRS libssh2.h 
                               /usr/include 
                               /usr/local/include)
set(libssh2_INCLUDE_DIR ${libssh2_INCLUDE_DIRS})

#Find the path to the library
find_library(libssh2_LIBRARY NAMES ssh2 
                             PATH  /usr/lib 
                                   /usr/local/lib)

#Set the Module Finder output variables
if (libssh2_INCLUDE_DIRS AND libssh2_LIBRARY)
	set(libssh2_FOUND TRUE)
endif()

if (libssh2_FOUND)
	if (NOT libssh2_FIND_QUIETLY)
		message(STATUS "Found libssh2: ${libssh2_LIBRARY}")
	endif()
else (libssh2_FOUND)
	if (libssh2_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find libssh2")
	endif()
endif()

################################################################################

