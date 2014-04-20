################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

#Find the path to the iperf program
find_program(iperf_PROGRAM iperf /usr/bin)

#Set the Module Finder output variables
if (iperf_PROGRAM)
	set(iperf_FOUND TRUE)
endif()

if (iperf_FOUND)
	if (NOT iperf_FIND_QUIETLY)
		message(STATUS "Found iperf: ${iperf_PROGRAM}")
	endif(NOT iperf_FIND_QUIETLY)
else (iperf_FOUND)
	if (iperf_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find iperf")
	endif()
endif()

################################################################################

