
include(yakl_set_cxx_flags.cmake)

set(YAKL_SOURCE YAKL.cpp gator_mod.F90 )
set(YAKL_CXX_SOURCE YAKL.cpp           )
set(YAKL_F90_SOURCE gator_mod.F90      )

yakl_set_cxx_flags( YAKL_CXX_SOURCE )

if ("${YAKL_ARCH}" STREQUAL "CUDA")
  enable_language(CUDA)
elseif ("${YAKL_ARCH}" STREQUAL "HIP")
  configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/rocPRIM/rocprim/include/rocprim/rocprim_version.hpp.in"
    "${CMAKE_CURRENT_SOURCE_DIR}/rocPRIM/rocprim/include/rocprim/rocprim_version.hpp"
    @ONLY
  )
  configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/hipCUB/hipcub/include/hipcub/hipcub_version.hpp.in"
    "${CMAKE_CURRENT_SOURCE_DIR}/hipCUB/hipcub/include/hipcub/hipcub_version.hpp"
    @ONLY
  )
elseif ("${YAKL_ARCH}" STREQUAL "SYCL")
elseif ("${YAKL_ARCH}" STREQUAL "OPENMP45")
else()
endif()

yakl_set_cxx_flags( YAKL_CXX_SOURCE )

add_library(yakl STATIC ${YAKL_SOURCE})

if ("${YAKL_ARCH}" STREQUAL "CUDA")
  target_include_directories(yakl PUBLIC cub)
  target_compile_features(yakl PUBLIC cxx_std_14)
  set_target_properties(yakl PROPERTIES LINKER_LANGUAGE CUDA CUDA_RESOLVE_DEVICE_SYMBOLS ON)
elseif ("${YAKL_ARCH}" STREQUAL "HIP")
  target_include_directories(yakl PUBLIC hipCUB/hipcub/include)
  target_include_directories(yakl PUBLIC rocPRIM/rocprim/include)
  target_compile_features(yakl PUBLIC cxx_std_14)
elseif ("${YAKL_ARCH}" STREQUAL "SYCL")
elseif ("${YAKL_ARCH}" STREQUAL "OPENMP45")
  target_compile_features(yakl PUBLIC cxx_std_11)
else()
endif()

target_include_directories(yakl PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


