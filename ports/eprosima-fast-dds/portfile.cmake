#based on https://github.com/microsoft/vcpkg/blob/master/ports/fastrtps/portfile.cmake

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/Fast-DDS
	REF e96f0828759ec6c5def1338b1244ac9c534f1854
	SHA512 57d14cf096f7361f4b16097095b9504c947d0b9e4b6cf27119d1d55efc9ab5b75bcf5f4e5dfa825475809b5d1c1d7799020c34c5adb8dd7bf3e477e18206c12e
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DVCPKG_BUILD_TYPE=release
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH share/eprosima-fast-dds/cmake)

vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/tools/fastdds/discovery/parser.py" "tool_path / '../../../bin'" "tool_path / '../../${PORT}'")

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static" OR NOT VCPKG_TARGET_IS_WINDOWS)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/tools")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)