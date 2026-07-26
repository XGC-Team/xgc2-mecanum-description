cmake_minimum_required(VERSION 3.0.2)
project(mecanum_description)

find_package(catkin REQUIRED)

catkin_package()

if(CATKIN_ENABLE_TESTING)
  catkin_add_nosetests(test/test_visual_assets.py)
endif()

install(DIRECTORY meshes urdf
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
