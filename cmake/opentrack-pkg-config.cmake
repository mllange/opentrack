include(FindPkgConfig)

function(otr_pkgconfig target)
    set(cflags "")
    set(includes "")
    set(ldflags "")
    foreach(i ${ARGN})
        set(k pkg-config_${i})
        pkg_check_modules(${k} REQUIRED QUIET ${i})
        if(${${k}_FOUND})
            set(cflags "${cflags} ${${k}_CFLAGS} ")
            set(includes ${includes} ${${k}_INCLUDE_DIRS} ${${k}_INCLUDEDIR})
            set(ldflags "${ldflags} ${${k}_LDFLAGS} ")
        endif()
    endforeach()
    #message(STATUS "foo | ${cflags} | ${includes} | ${ldflags}")
    set_property(TARGET ${target} APPEND_STRING PROPERTY COMPILE_FLAGS " ${cflags}")
    target_include_directories(${target} SYSTEM PRIVATE ${includes})
    set_property(TARGET ${target} APPEND_STRING PROPERTY LINK_FLAGS " ${ldflags}")
endfunction()

