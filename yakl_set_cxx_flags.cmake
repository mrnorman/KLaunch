
function(yakl_set_cxx_flags YAKL_CXX_SOURCE)

  if ("${YAKL_ARCH}" STREQUAL "CUDA")
    set_source_files_properties(${YAKL_CXX_SOURCE} PROPERTIES LANGUAGE CUDA)
    set(YAKL_CXX_FLAGS "-D__USE_CUDA__ --expt-extended-lambda --expt-relaxed-constexpr ${CUDA_FLAGS}")
    set_source_files_properties(${YAKL_CXX_SOURCE} PROPERTIES COMPILE_FLAGS "${YAKL_CXX_FLAGS}")
    include_directories(cub)
  elseif ("${ARCH}" STREQUAL "HIP")
    set(YAKL_CXX_FLAGS "-D__USE_HIP__ ${HIP_FLAGS}")
    set_source_files_properties(${YAKL_CXX_SOURCE} PROPERTIES COMPILE_FLAGS "${YAKL_CXX_FLAGS}")
    include_directories(hipCUB/hipcub/include)
    include_directories(rocPRIM/rocprim/include)
  elseif ("${ARCH}" STREQUAL "SYCL")
    set(YAKL_CXX_FLAGS "-D__USE_SYCL__ --intel -fsycl ${SYCL_FLAGS}")
    set_source_files_properties(${YAKL_CXX_SOURCE} PROPERTIES COMPILE_FLAGS "${YAKL_CXX_FLAGS}")
  elseif ("${ARCH}" STREQUAL "OPENMP45")
    set(YAKL_CXX_FLAGS "-D__USE_OPENMP45__ ${OPENMP45_FLAGS}")
    set_source_files_properties(${YAKL_CXX_SOURCE} PROPERTIES COMPILE_FLAGS "${YAKL_CXX_FLAGS}")
  else()
  endif()

  add_library(yakl STATIC ${YAKL_SOURCE})

  target_include_directories(yakl PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

  if ("${ARCH}" STREQUAL "CUDA")
    set_target_properties(yakl PROPERTIES LINKER_LANGUAGE CUDA CUDA_SEPARABLE_COMPILATION OFF CUDA_RESOLVE_DEVICE_SYMBOLS ON)
    target_include_directories(yakl PUBLIC cub)
  endif()

  if ("${ARCH}" STREQUAL "SYCL")
  endif()

endfunction()
