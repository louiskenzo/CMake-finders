################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

#Find the path to the headers
find_path(yaml-cpp_INCLUDE_DIRS yaml.h 
                               /usr/include/yaml-cpp 
                               /usr/local/include/yaml-cpp)
set(yaml-cpp_INCLUDE_DIR ${yaml-cpp_INCLUDE_DIRS})

#Find the path to the library
find_library(yaml-cpp_LIBRARY NAMES yaml-cpp 
                              PATH  /usr/lib 
                                    /usr/local/lib)

#Set the Module Finder output variables
if (yaml-cpp_INCLUDE_DIRS AND yaml-cpp_LIBRARY)
	set(yaml-cpp_FOUND TRUE)
endif()

if (yaml-cpp_FOUND)
	if (NOT yaml-cpp_FIND_QUIETLY)
		message(STATUS "Found yaml-cpp: ${yaml-cpp_LIBRARY}")
	endif()
else (yaml-cpp_FOUND)
	if (yaml-cpp_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find yaml-cpp")
	endif()
endif()

################################################################################

