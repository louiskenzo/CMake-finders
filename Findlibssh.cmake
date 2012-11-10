################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Boomer project                                #
#                                                                              #
################################################################################

#Find the path to the headers
find_path(libssh_INCLUDE_DIRS libssh.h 
                              /usr/include/libssh 
                              /usr/local/include/libssh)
set(libssh_INCLUDE_DIR ${libssh_INCLUDE_DIRS})

#Find the path to the library
find_library(libssh_LIBRARY NAMES ssh 
                            PATH /usr/lib 
                                 /usr/local/lib)

#Set the Module Finder output variables
if (libssh_INCLUDE_DIRS AND libssh_LIBRARY)
	set(libssh_FOUND TRUE)
endif()

if (libssh_FOUND)
	if (NOT libssh_FIND_QUIETLY)
		message(STATUS "Found libssh: ${libssh_LIBRARY}")
	endif()
else (libssh_FOUND)
	if (libssh_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find libssh")
	endif()
endif()

################################################################################

