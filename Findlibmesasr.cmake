################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Boomer project                                #
#                                                                              #
################################################################################

#Find the path to the libmesasr headers
find_path(libmesasr_INCLUDE_DIRS NAMES libMesaSR.h definesSR.h
                                 PATHS /usr/include)
set(libmesasr_INCLUDE_DIR ${libmesasr_INCLUDE_DIRS})

#Find the path to the libmesasr library
find_library(libmesasr_LIBRARY mesasr 
                               /usr/lib)

#Set the Module Finder output variables
if (libmesasr_INCLUDE_DIRS AND libmesasr_LIBRARY)
	set(libmesasr_FOUND TRUE)
endif()

if (libmesasr_FOUND)
	if (NOT libmesasr_FIND_QUIETLY)
		message(STATUS "Found libmesasr: ${libmesasr_LIBRARY}")
	endif()
else (libmesasr_FOUND)
	if (libmesasr_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find libmesasr")
	endif()
endif()

################################################################################

