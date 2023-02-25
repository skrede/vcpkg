vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/RPC
	REF 85274fa21290c5382044904d459afd17b38ebca7
	SHA512 745eb4b590542775f6eaf3e811b7aa3ac5cfa7caa520b82e82c7a9ea1b479d33fa3d42858385cd3cd497baf2e0b1bfaf411efb2a90e3bfa43d59ecec7194ae60
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

