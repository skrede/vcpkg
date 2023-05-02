# WINDOWS_EXPORT_ALL_SYMBOLS doesn't work.
# unresolved external symbol "public: static unsigned int const foonathan::memory::detail::memory_block_stack::implementation_offset
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO foonathan/memory
	REF 0.7-2
	SHA512 e84a567a832138f477997d7b4cbd827a82dfd5d9de8dc0d2833995366253501155663c7d73407ac43a7fd58d42774ddb3582c557ca12800316a732ac7ccab823
	HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS FEATURES
	tool FOONATHAN_MEMORY_BUILD_TOOLS
)

vcpkg_cmake_configure(
	SOURCE_PATH "${SOURCE_PATH}"
	OPTIONS
	${FEATURE_OPTIONS}
	-DFOONATHAN_MEMORY_BUILD_EXAMPLES=OFF
	-DFOONATHAN_MEMORY_BUILD_TESTS=OFF
	-DBUILD_SHARED_LIBS=ON
)

vcpkg_cmake_install()

if(EXISTS "${CURRENT_PACKAGES_DIR}/cmake")
	vcpkg_cmake_config_fixup(CONFIG_PATH cmake PACKAGE_NAME foonathan_memory)
elseif(EXISTS "${CURRENT_PACKAGES_DIR}/share/foonathan_memory/cmake")
	vcpkg_cmake_config_fixup(CONFIG_PATH share/foonathan_memory/cmake PACKAGE_NAME foonathan_memory)
endif()

vcpkg_copy_pdbs()

# Place header files into the right folders
# The original layout is not a problem for CMake-based project.
file(COPY
	"${CURRENT_PACKAGES_DIR}/include/foonathan_memory/foonathan"
	DESTINATION "${CURRENT_PACKAGES_DIR}/include"
	)
file(GLOB
	COMP_INCLUDE_FILES
	"${CURRENT_PACKAGES_DIR}/include/foonathan_memory/comp/foonathan/*.hpp"
	)
file(COPY
	${COMP_INCLUDE_FILES}
	DESTINATION "${CURRENT_PACKAGES_DIR}/include/foonathan"
	)
file(COPY
	"${CURRENT_PACKAGES_DIR}/include/foonathan_memory/foonathan/memory/config_impl.hpp"
	DESTINATION "${CURRENT_PACKAGES_DIR}/include/foonathan/memory"
	)
file(REMOVE_RECURSE
	"${CURRENT_PACKAGES_DIR}/include/foonathan_memory"
	)

# The Debug version of this lib is built with:
# #define FOONATHAN_MEMORY_DEBUG_FILL 1
# and Release version is built with:
# #define FOONATHAN_MEMORY_DEBUG_FILL 0
# We only have the Release version header files installed, however.
#vcpkg_replace_string(
#	"${CURRENT_PACKAGES_DIR}/include/foonathan/memory/detail/debug_helpers.hpp"
#	"#if FOONATHAN_MEMORY_DEBUG_FILL"
#	"#ifndef NDEBUG //#if FOONATHAN_MEMORY_DEBUG_FILL"
#)

file(REMOVE_RECURSE
	"${CURRENT_PACKAGES_DIR}/debug/include"
	"${CURRENT_PACKAGES_DIR}/debug/share"
	)

file(REMOVE
	"${CURRENT_PACKAGES_DIR}/debug/LICENSE"
	"${CURRENT_PACKAGES_DIR}/debug/README.md"
	"${CURRENT_PACKAGES_DIR}/LICENSE"
	"${CURRENT_PACKAGES_DIR}/README.md"
	)

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR
	VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	set(EXECUTABLE_SUFFIX ".exe")
else()
	set(EXECUTABLE_SUFFIX "")
endif()

if(EXISTS "${CURRENT_PACKAGES_DIR}/bin/nodesize_dbg${EXECUTABLE_SUFFIX}")
	file(COPY
		"${CURRENT_PACKAGES_DIR}/bin/nodesize_dbg${EXECUTABLE_SUFFIX}"
		DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}"
		)
	vcpkg_copy_tool_dependencies("${CURRENT_PACKAGES_DIR}/tools/${PORT}")

	if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
		file(REMOVE_RECURSE
			"${CURRENT_PACKAGES_DIR}/bin"
			"${CURRENT_PACKAGES_DIR}/debug/bin"
			)
	else()
		file(REMOVE
			"${CURRENT_PACKAGES_DIR}/bin/nodesize_dbg${EXECUTABLE_SUFFIX}"
			"${CURRENT_PACKAGES_DIR}/debug/bin/nodesize_dbg${EXECUTABLE_SUFFIX}"
			)
	endif()
endif()

# Handle copyright
configure_file("${SOURCE_PATH}/LICENSE" "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" COPYONLY)
