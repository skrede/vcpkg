#based on https://github.com/microsoft/vcpkg/blob/master/ports/foonathan-memory/portfile.cmake

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/foonathan_memory_vendor
	REF 8db2afc097db4cebe414ae27cdb3af1480ae46e7
	SHA512 1d5e899ec46fa9c6fc2ad9c0a93c3b0fb7d92a153c46565e2a31b37b8c671c3e66ef9e4210ccd656e826f9b687936cd1d82d1c95e12459a259057ebc196b5d96
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
		-DBUILD_SHARED_LIBS=ON
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    tool FOONATHAN_MEMORY_BUILD_TOOLS
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        ${FEATURE_OPTIONS}
        -DFOONATHAN_MEMORY_BUILD_EXAMPLES=OFF
        -DFOONATHAN_MEMORY_BUILD_TESTS=OFF
)

vcpkg_install_cmake()

if(EXISTS ${CURRENT_PACKAGES_DIR}/cmake)
    vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/foonathan_memory)
elseif(EXISTS ${CURRENT_PACKAGES_DIR}/share/foonathan_memory/cmake)
    vcpkg_fixup_cmake_targets(CONFIG_PATH share/foonathan_memory/cmake TARGET_PATH share/foonathan_memory)
endif()

vcpkg_copy_pdbs()

# Place header files into the right folders
# The original layout is not a problem for CMake-based project.
file(COPY
    ${CURRENT_PACKAGES_DIR}/include/foonathan_memory/foonathan
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
)
file(GLOB
    COMP_INCLUDE_FILES
    ${CURRENT_PACKAGES_DIR}/include/foonathan_memory/comp/foonathan/*.hpp
)
file(COPY
    ${COMP_INCLUDE_FILES}
    DESTINATION ${CURRENT_PACKAGES_DIR}/include/foonathan
)
file(COPY
    ${CURRENT_PACKAGES_DIR}/include/foonathan_memory/config_impl.hpp
    DESTINATION ${CURRENT_PACKAGES_DIR}/include/foonathan/memory
)
file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/include/foonathan_memory
)
vcpkg_replace_string(
    ${CURRENT_PACKAGES_DIR}/share/foonathan_memory/foonathan_memory-config.cmake
    "\${_IMPORT_PREFIX}/include/foonathan_memory/comp;\${_IMPORT_PREFIX}/include/foonathan_memory"
    "\${_IMPORT_PREFIX}/include"
)

# Place header files into the right folders - Done!

# The Debug version of this lib is built with:
# #define FOONATHAN_MEMORY_DEBUG_FILL 1
# and Release version is built with:
# #define FOONATHAN_MEMORY_DEBUG_FILL 0
# We only have the Release version header files installed, however.

vcpkg_replace_string(
    ${CURRENT_PACKAGES_DIR}/include/foonathan/memory/detail/debug_helpers.hpp
    "#if FOONATHAN_MEMORY_DEBUG_FILL"
    "#ifndef NDEBUG //#if FOONATHAN_MEMORY_DEBUG_FILL"
)

file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/debug/include
    ${CURRENT_PACKAGES_DIR}/debug/share
)

file(REMOVE
    ${CURRENT_PACKAGES_DIR}/debug/LICENSE
    ${CURRENT_PACKAGES_DIR}/debug/README.md
    ${CURRENT_PACKAGES_DIR}/LICENSE
    ${CURRENT_PACKAGES_DIR}/README.md
)

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR 
   VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    set(EXECUTABLE_SUFFIX ".exe")
else()
    set(EXECUTABLE_SUFFIX "")
endif()

if(EXISTS ${CURRENT_PACKAGES_DIR}/bin/nodesize_dbg${EXECUTABLE_SUFFIX})
    file(COPY
        ${CURRENT_PACKAGES_DIR}/bin/nodesize_dbg${EXECUTABLE_SUFFIX}
        DESTINATION ${CURRENT_PACKAGES_DIR}/tools/${PORT}
    )
    vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

    if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
        file(REMOVE_RECURSE
            ${CURRENT_PACKAGES_DIR}/bin
            ${CURRENT_PACKAGES_DIR}/debug/bin
        )
    else()
        file(REMOVE
            ${CURRENT_PACKAGES_DIR}/bin/nodesize_dbg${EXECUTABLE_SUFFIX}
            ${CURRENT_PACKAGES_DIR}/debug/bin/nodesize_dbg${EXECUTABLE_SUFFIX}
        )
    endif()
endif()

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
