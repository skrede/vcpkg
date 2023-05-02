#based on https://github.com/microsoft/vcpkg/blob/master/ports/fastrtps/portfile.cmake

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/boost_threadpool
	REF 0d3895c70aac3993a25100d60ea29f09ffc1260a
	SHA512 b5dab2b03740355dac0b2c60b0ef79b49c672b58dfc301ea498e98a67c96f2856c12b5b71f70aaa0fb14b2ea0104d4d6d7eea4c9ee7c76d6bd97dcdb76d63a8f
    HEAD_REF master
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/config.cmake.in" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(PACKAGE_NAME "BoostThreadpool")

file(INSTALL "${SOURCE_PATH}/LICENSE_1_0.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)