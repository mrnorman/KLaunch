
include(../../yakl_set_cxx_flags.cmake)

set(MYSRC FArray.cpp)

add_executable(FArray ${MYSRC})
target_compile_features(FArray PUBLIC cxx_std_14)
target_link_libraries(FArray yakl)

yakl_set_cxx_flags(${MYSRC})

add_test(NAME FArray_test COMMAND ./FArray)

