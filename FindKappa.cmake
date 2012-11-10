################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Kappa project                                 #
#                                                                              #
################################################################################

#Find the path to the Kappa headers and library
find_path(Kappa_INCLUDE_DIRS NAMES kappa.h
                             PATHS /usr/include/kappa
                                   /usr/local/include/kappa)
set(Kappa_INCLUDE_DIR ${Kappa_INCLUDE_DIRS})
find_path(Kappa_LIBRARY_DIRS NAMES libkappa.so
                             PATHS /usr/lib/kappa
                                   /usr/local/lib/kappa)
set(Kappa_LIBRARY_DIR ${Kappa_LIBRARY_DIRS})

#Set the Module Finder output variables
if (Kappa_INCLUDE_DIR AND Kappa_LIBRARY_DIR)
	set(Kappa_FOUND TRUE)
endif()

if (Kappa_FOUND)
	if (NOT Kappa_FIND_QUIETLY)
		message(STATUS "Found Kappa: ${Kappa_LIBRARY_DIR}")
	endif()
else ()
	if (Kappa_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find Kappa")
	endif()
endif()

################################################################################

