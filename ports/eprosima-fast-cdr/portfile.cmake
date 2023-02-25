vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/Fast-CDR
	REF 6184f25f24cbb3a4abac886669d3c966818b1ccb
	SHA512 fbfd8d980051089a838582d41f34a7a9f159eb1d82673b2dc8620f5fdb45556e9104fa92592f186702e01e588ae545f1277a7d5c7981dc8feda88a43366c3e9d
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_fixup_cmake_targets()

