# WINDOWS_EXPORT_ALL_SYMBOLS doesn't work.
# unresolved external symbol "public: static unsigned int const foonathan::memory::detail::memory_block_stack::implementation_offset
vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO eprosima/fastcdr
	REF 1.0.27
	SHA512 e78bbee045c30161db49e025e7160590db88b322081752fcf6962ca298726bd9607de17d383e541158d4fe58fcca136811d7c752146ee8881e4ef3fe4ef899ac
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

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME "fastcdr" CONFIG_PATH lib/cmake/fastcdr)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/lib/fastcdr ${CURRENT_PACKAGES_DIR}/debug/lib/fastcdr)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
	vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/fastcdr/eProsima_auto_link.h" "(defined(_DLL) || defined(_RTLDLL)) && defined(EPROSIMA_DYN_LINK)" "1")
	vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/fastcdr/fastcdr_dll.h" "defined(FASTCDR_DYN_LINK)" "1")
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")