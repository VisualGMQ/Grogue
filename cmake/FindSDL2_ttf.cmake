if (NOT TARGET SDL2_ttf)
    if (NOT SDL2_TTF_ROOT)
        set(SDL2_TTF_ROOT "" CACHE PATH "SDL2_ttf root directory")
    endif()
    if (WIN32)  # Windows
        IsMSVCBackend(is_msvc_backend)
        IsMinGWBackend(is_mingw_backend)
        IsX64Compiler(is_x64_compiler)
        if (${is_msvc_backend})
            set(INCLUDE_DIR "${SDL2_TTF_ROOT}/include")
            if (${is_x64_compiler})
                set(LIB_DIR "${SDL2_TTF_ROOT}/lib/x64")
                set(SDL2_TTF_DYNAMIC_LIB_DIR "${SDL2_TTF_ROOT}/lib/x64" CACHE PATH "SDL2_ttf.dll directory" FORCE)
            else()
                set(LIB_DIR "${SDL2_TTF_ROOT}/lib/x86")
                set(SDL2_TTF_DYNAMIC_LIB_DIR "${SDL2_TTF_ROOT}/lib/x86" CACHE PATH "SDL2_ttf.dll directory" FORCE)
            endif()
            set(LIB_PATH "${LIB_DIR}/SDL2_ttf.lib")
            set(DYNAMIC_LIB_PATH "${LIB_DIR}/SDL2_ttf.dll")
        elseif (${is_mingw_backend}) # use MINGW
            if(${is_x64_compiler})
                set(INCLUDE_DIR "${SDL2_TTF_ROOT}/x86_64-w64-mingw32/include")
                set(LIB_DIR "${SDL2_TTF_ROOT}/x86_64-w64-mingw32/lib")
                set(SDL2_TTF_DYNAMIC_LIB_DIR "${SDL2_TTF_ROOT}/x86_64-w64-mingw32/bin" CACHE PATH "SDL2_ttf.dll directory" FORCE)
            else()
                set(INCLUDE_DIR "${SDL2_TTF_ROOT}/i686-w64-mingw32/include")
                set(LIB_DIR "${SDL2_TTF_ROOT}/i686-w64-mingw32/lib")
                set(SDL2_TTF_DYNAMIC_LIB_DIR "${SDL2_TTF_ROOT}/i686-w64-mingw32/bin" CACHE PATH "SDL2_ttf.dll directory" FORCE)
            endif()
            set(LIB_PATH "${LIB_DIR}/libSDL2_ttf.a")
            set(DYNAMIC_LIB_PATH "${LIB_DIR}/SDL2_ttf.dll")
        else()
            message(FATAL_ERROR "your compiler don't support, please use MSVC, Clang++ or MinGW")
        endif()

        mark_as_advanced(SDL2_TTF_DYNAMIC_LIB_DIR)
        add_library(SDL2::TTF SHARED IMPORTED GLOBAL)
        set_target_properties(
            SDL2::TTF
            PROPERTIES
                IMPORTED_LOCATION ${DYNAMIC_LIB_PATH}
                IMPORTED_IMPLIB ${LIB_PATH}
                INTERFACE_INCLUDE_DIRECTORIES ${INCLUDE_DIR}
        )
        add_library(SDL2_ttf INTERFACE IMPORTED GLOBAL)
        target_link_libraries(SDL2_ttf INTERFACE SDL2::TTF)
    else()  # Linux, MacOSX
        find_package(PkgConfig REQUIRED)
        pkg_check_modules(SDL2_ttf SDL2_ttf REQUIRED IMPORTED_TARGET)
        add_library(SDL2_ttf ALIAS PkgConfig::SDL2_ttf)
    endif()
endif()