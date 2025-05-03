add_executable(linked_list linked_list.c)
target_compile_options(linked_list PRIVATE -fsanitize=address -fno-omit-frame-pointer -g)
target_link_options(linked_list PRIVATE -fsanitize=address)

add_executable(app app.c stack.c)
target_compile_options(linked_list PRIVATE -fsanitize=address -fno-omit-frame-pointer -g)
target_link_options(linked_list PRIVATE -fsanitize=address)

add_executable(stack_tests StackTests.cxx)
target_compile_options(stack_tests PRIVATE -fsanitize=address -fno-omit-frame-pointer -g)
target_link_options(stack_tests PRIVATE -fsanitize=address)
target_include_directories(stack_tests PRIVATE ${CMAKE_SOURCE_DIR}/src/utils)
