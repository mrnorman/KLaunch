
include(../../yakl_set_cxx_flags.cmake)

set(MYSRC CArray.cpp)

add_executable(CArray ${MYSRC})
target_compile_features(CArray PUBLIC cxx_std_14)
target_link_libraries(CArray yakl)

yakl_set_cxx_flags(${MYSRC})

add_test(NAME CArray_test COMMAND ./CArray)

