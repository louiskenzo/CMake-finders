################################################################################
#                                                                              #
#                               Kyoto University                               #
#                               Okuno laboratory                               #
#                                Boomer project                                #
#                                                                              #
################################################################################

#Find the path to the mpstat program
find_program(mpstat_PROGRAM mpstat /usr/bin)

#Set the Module Finder output variables
if (mpstat_PROGRAM)
	set(mpstat_FOUND TRUE)
endif()

if (mpstat_FOUND)
	if (NOT mpstat_FIND_QUIETLY)
		message(STATUS "Found mpstat: ${mpstat_PROGRAM}")
	endif()
else (mpstat_FOUND)
	if (mpstat_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find mpstat")
	endif()
endif()

################################################################################

