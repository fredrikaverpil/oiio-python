include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OpenImageIO/oiio
    REF Release-2.0.5
    SHA512 2bf6b3d998e9b7bda90b9dfd3e30702c3c857f6f90ab8be10fd3dc9617ecccc62464a8198a7804d130bdb39b2475c1ce14af129b8ccc371a21e92c2e637a5413
    HEAD_REF master
    PATCHES
        # fix_libraw: replace 'LibRaw_r_LIBRARIES' occurences by 'LibRaw_LIBRARIES'
        #             since libraw port installs 'raw_r' library as 'raw'
        fix_libraw.patch
        use-webp.patch
)

file(REMOVE_RECURSE "${SOURCE_PATH}/ext")
file(MAKE_DIRECTORY "${SOURCE_PATH}/ext/robin-map/tsl")

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(BUILDSTATIC ON)
    set(LINKSTATIC ON)
else()
    set(BUILDSTATIC OFF)
    set(LINKSTATIC OFF)
endif()

# Features
set(USE_LIBRAW OFF)
if("libraw" IN_LIST FEATURES)
    set(USE_LIBRAW ON)
endif()

set(ENV{OIIO_PYTHON_VERSION} "3.7")

if(UNIX AND NOT APPLE)
    message("DEBUG - CURRENT DIRECTORY ${CMAKE_CURRENT_LIST_DIR}")
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/FindOpenEXR.cmake DESTINATION ${SOURCE_PATH}/src/cmake/modules)
    file(COPY ${CMAKE_CURRENT_LIST_DIR}/imageio.cpp DESTINATION ${SOURCE_PATH}/src/libOpenImageIO)
    message("DEBUG - COPIED FIND_OPEN_EXR FILE!")
    message("DEBUG - COPIED PATCHED imageio.cpp FILE!")
endif()

if(WIN32)
    set(HIDE_SYMBOLS ON)
else()
    set(HIDE_SYMBOLS OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DOIIO_BUILD_TOOLS=OFF
        -DOIIO_BUILD_TESTS=OFF
        -DHIDE_SYMBOLS=${HIDE_SYMBOLS}
        -DUSE_DICOM=OFF
        -DUSE_FFMPEG=OFF
        -DUSE_FIELD3D=OFF
        -DUSE_FREETYPE=OFF
        -DUSE_GIF=OFF
        -DUSE_LIBRAW=${USE_LIBRAW}
        -DUSE_NUKE=OFF
        -DUSE_OCIO=OFF
        -DUSE_OPENCV=OFF
        -DUSE_OPENJPEG=OFF
        -DUSE_OPENSSL=OFF
        -DUSE_PTEX=OFF
        -DUSE_PYTHON=ON
        -DUSE_QT=OFF
        -DUSE_WEBP=OFF
        -DBUILDSTATIC=${BUILDSTATIC}
        -DLINKSTATIC=${LINKSTATIC}
        -DBUILD_MISSING_PYBIND11=ON
        -DBUILD_MISSING_DEPS=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
        -DVERBOSE=ON
    OPTIONS_DEBUG
        -DOPENEXR_CUSTOM_LIB_DIR=${CURRENT_INSTALLED_DIR}/debug/lib
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

# Clean
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/doc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/doc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/openimageio)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/openimageio/LICENSE.md ${CURRENT_PACKAGES_DIR}/share/openimageio/copyright)
