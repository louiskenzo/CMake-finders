################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

#Find the path to the Eigen library headers
find_path(Eigen_INCLUDE_DIRS Core
                             /usr/include/eigen2/Eigen)

#Set the Module Finder output variables
if (Eigen_INCLUDE_DIRS)
	# the eigen2 directory doesn't contain any file so we can't find_path it, but it's the real root of the Eigen installation
	set(Eigen_INCLUDE_DIRS ${Eigen_INCLUDE_DIRS}/..)
	set(Eigen_FOUND TRUE)
endif ()
set(Eigen_INCLUDE_DIR ${Eigen_INCLUDE_DIRS})

if (Eigen_FOUND)
	if (NOT Eigen_FIND_QUIETLY)
		message(STATUS "Found Eigen: ${Eigen_INCLUDE_DIRS}")
	endif()
else (Eigen_FOUND)
	if (Eigen_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find Eigen")
	endif ()
endif()

################################################################################

