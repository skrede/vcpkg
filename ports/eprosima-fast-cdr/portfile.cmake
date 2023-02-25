# based on https://github.com/microsoft/vcpkg/blob/master/ports/fastcdr/portfile.cmake

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/Fast-CDR
	REF 6184f25f24cbb3a4abac886669d3c966818b1ccb
	SHA512 e37068503df806f5809f010e16e14cabac67e99ea21a3747b5efebe5765eb1446ad93e39f5b1fd857809c532897c4ca1e4f2a8bdc2df21c8deb8ee76261cea6f
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/eprosima-fast-cdr)

vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/lib/eprosima-fast-cdr ${CURRENT_PACKAGES_DIR}/debug/lib/eprosima-fast-cdr)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/eprosima-fast-cdr/eProsima_auto_link.h" "(defined(_DLL) || defined(_RTLDLL)) && defined(EPROSIMA_DYN_LINK)" "1")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/eprosima-fast-cdr/eprosima-fast-cdr_dll.h" "defined(eprosima-fast-cdr_DYN_LINK)" "1")
endif()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

