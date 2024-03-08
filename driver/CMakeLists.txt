project(driver)

aux_source_directory(. DIR_SRCS)

add_library(${PROJECT_NAME} OBJECT ${DIR_SRCS} ${DIR_ASMS})

set(TARGET_LIBS ${TARGET_LIBS} ${PROJECT_NAME} PARENT_SCOPE)