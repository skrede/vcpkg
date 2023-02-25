vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
	REPO eProsima/Fast-DDS
	REF e96f0828759ec6c5def1338b1244ac9c534f1854
	SHA512 57d14cf096f7361f4b16097095b9504c947d0b9e4b6cf27119d1d55efc9ab5b75bcf5f4e5dfa825475809b5d1c1d7799020c34c5adb8dd7bf3e477e18206c12e
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_fixup_cmake_targets()

