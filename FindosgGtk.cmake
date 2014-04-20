################################################################################
#                                                                              #
#                              Louis-Kenzo Cahier                              #
#                                                                              #
################################################################################

#Find the path to the osgGtk headers
find_path(osgGtk_INCLUDE_DIR NAMES osgGtkmm.h 
                             PATHS /usr/include
                                   /usr/local/include
                             PATH_SUFFIXES osgGtkmm-0.1)
find_path(gtkglmm_INCLUDE_DIR NAMES gtkglmm.h 
                              PATHS /usr/include
                                    /usr/local/include
                              PATH_SUFFIXES gtkglextmm-1.2)
find_path(gdkglextmm-config_INCLUDE_DIR NAMES gdkglextmm-config.h
                                        PATHS /usr/lib/gtkglextmm-1.2/include)
find_path(gdkglext-config_INCLUDE_DIR NAMES gdkglext-config.h
                                      PATHS /usr/lib/gtkglext-1.0/include)
find_path(gdkgltypes_INCLUDE_DIR NAMES gdk/gdkgltypes.h
                                 PATHS /usr/include/gtkglext-1.0)
set(osgGtk_INCLUDE_DIRS ${osgGtk_INCLUDE_DIR} 
                        ${gtkglmm_INCLUDE_DIR} 
                        ${gdkglextmm-config_INCLUDE_DIR} 
                        ${gdkglext-config_INCLUDE_DIR}
                        ${gdkgltypes_INCLUDE_DIR})


#Find the path to the osgGtk library
find_library(osgGtk_LIBRARY NAMES osgGtk
                            PATHS /usr/lib
                                  /usr/local/lib)

#Set the Module Finder output variables
if (osgGtk_INCLUDE_DIRS AND osgGtk_LIBRARY)
	set(osgGtk_FOUND TRUE)
endif()

if (osgGtk_FOUND)
	if (NOT osgGtk_FIND_QUIETLY)
		message(STATUS "Found osgGtk: ${osgGtk_LIBRARY}")
	endif()
else (osgGtk_FOUND)
	if (osgGtk_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find osgGtk")
	endif()
endif()

################################################################################

