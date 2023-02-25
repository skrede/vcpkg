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

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

