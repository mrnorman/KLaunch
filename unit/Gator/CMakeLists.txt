
include(../../yakl_set_cxx_flags.cmake)

set(MYSRC TestGator.cpp)

add_executable(Gator ${MYSRC})
target_compile_features(Gator PUBLIC cxx_std_14)
target_link_libraries(Gator yakl)

yakl_set_cxx_flags(${MYSRC})

add_test(NAME Gator_test COMMAND ./Gator)

