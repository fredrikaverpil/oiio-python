// https://github.com/Microsoft/vcpkg/blob/9fe14bc18ec4b8f12238cd8790c44e42325f8e52/ports/openimageio/portfile.cmake

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OpenImageIO/oiio
    REF bb2c617e83b3b264c9f4b7503d3c01c16570fdb7
    SHA512 5c198bd53ebc84847df3f8c40c0eedcb16d9e45ad9627d2e69faa44ba0966f74cac29cb3e93af5df7162ef4af82101770118e10695e25b287d05d499932fab0f
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

set(ENV{OIIO_PYTHON_VERSION} "3.6")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DOIIO_BUILD_TOOLS=OFF
        -DOIIO_BUILD_TESTS=OFF
        -DHIDE_SYMBOLS=ON
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