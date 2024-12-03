add_executable(linked_list linked_list.c)
target_compile_options(linked_list PRIVATE -fsanitize=address -fno-omit-frame-pointer -g)
target_link_options(linked_list PRIVATE -fsanitize=address)

add_executable(app app.c stack.c)
target_compile_options(linked_list PRIVATE -fsanitize=address -fno-omit-frame-pointer -g)
target_link_options(linked_list PRIVATE -fsanitize=address)
