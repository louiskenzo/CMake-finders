################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Boomer project                                #
#                                                                              #
################################################################################

#Find the path to the cloc program
find_program(cloc_PROGRAM cloc /usr/bin)

#Set the Module Finder output variables
if (cloc_PROGRAM)
	set(cloc_FOUND TRUE)
endif()

if (cloc_FOUND)
	if (NOT cloc_FIND_QUIETLY)
		message(STATUS "Found cloc: ${cloc_PROGRAM}")
	endif()
else (cloc_FOUND)
	if (cloc_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find cloc")
	endif()
endif()

################################################################################

