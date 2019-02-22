# Patches are from: 
# - https://github.com/python-cmake-buildsystem/python-cmake-buildsystem/tree/master/patches/2.7.13/Windows-MSVC/1900
# - https://github.com/Microsoft/vcpkg/tree/master/ports/python3

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic AND VCPKG_CRT_LINKAGE STREQUAL static)
    message(STATUS "Warning: Dynamic library with static CRT is not supported. Building static library.")
    set(VCPKG_LIBRARY_LINKAGE static)
endif()

set(PYTHON_VERSION_MAJOR  2)
set(PYTHON_VERSION_MINOR  7)
set(PYTHON_VERSION_PATCH  14)
set(PYTHON_VERSION        ${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}.${PYTHON_VERSION_PATCH})
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/python-${PYTHON_VERSION})

include(vcpkg_common_functions)

vcpkg_download_distfile(
    PYTHON_ARCHIVE
    URLS https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz
    FILENAME Python-${PYTHON_VERSION}.tar.xz
    SHA512 78310b0be6388ffa15f29a80afb9ab3c03a572cb094e9da00cfe391afadb51696e41f592eb658d6a31a2f422fdac8a55214a382cbb8cfb43d4a127d5b35ea7f9
)

vcpkg_extract_source_archive(${PYTHON_ARCHIVE})

set(_PYTHON_PATCHES "")

if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    list(APPEND _PYTHON_PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/004-static-library-msvc.patch
        ${CMAKE_CURRENT_LIST_DIR}/006-static-fix-headers.patch
    )
endif()
if (VCPKG_CRT_LINKAGE STREQUAL static)
    list(APPEND _PYTHON_PATCHES ${CMAKE_CURRENT_LIST_DIR}/005-static-crt-msvc.patch)
endif()

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/001-build-msvc.patch
        ${CMAKE_CURRENT_LIST_DIR}/002-build-msvc.patch
        ${CMAKE_CURRENT_LIST_DIR}/003-build-msvc.patch
        ${_PYTHON_PATCHES}
        ${CMAKE_CURRENT_LIST_DIR}/007-fix-build-path.patch
)

if (VCPKG_TARGET_ARCHITECTURE MATCHES "x86")
    set(BUILD_ARCH "Win32")
    set(OUT_DIR "win32")
elseif (VCPKG_TARGET_ARCHITECTURE MATCHES "x64")
    set(BUILD_ARCH "x64")
    set(OUT_DIR "amd64")
else()
    message(FATAL_ERROR "Unsupported architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/PCBuild/pythoncore.vcxproj
    PLATFORM ${BUILD_ARCH})

file(GLOB HEADERS ${SOURCE_PATH}/Include/*.h)
file(COPY ${HEADERS} ${SOURCE_PATH}/PC/pyconfig.h DESTINATION ${CURRENT_PACKAGES_DIR}/include/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR})

file(COPY ${SOURCE_PATH}/Lib DESTINATION ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR})

file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}_d.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
    file(COPY ${SOURCE_PATH}/PCBuild/${OUT_DIR}/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}_d.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR}/LICENSE ${CURRENT_PACKAGES_DIR}/share/python${PYTHON_VERSION_MAJOR}/copyright)

vcpkg_copy_pdbs()
