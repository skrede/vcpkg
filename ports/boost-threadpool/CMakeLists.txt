cmake_minimum_required(VERSION 3.22.3)
project(threadpool VERSION 0.2.6)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

find_package(Boost REQUIRED)

add_library(BoostThreadpool INTERFACE)

configure_package_config_file(config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/BoostThreadpoolConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/BoostThreadpool
    NO_SET_AND_CHECK_MACRO
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/BoostThreadpoolConfig-version.cmake
    VERSION ${CMAKE_PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
    ${CMAKE_CURRENT_BINARY_DIR}/BoostThreadpoolConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/BoostThreadpoolConfig-version.cmake
    DESTINATION
    ${CMAKE_INSTALL_DATADIR}/BoostThreadpool
)

install(TARGETS BoostThreadpool EXPORT BoostThreadpool-targets)

install(DIRECTORY boost/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/boost/)

install(EXPORT BoostThreadpool-targets
    DESTINATION ${CMAKE_INSTALL_DATADIR}/BoostThreadpool)

