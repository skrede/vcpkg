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
vcpkg_fixup_cmake_targets()

