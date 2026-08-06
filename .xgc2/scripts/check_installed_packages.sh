#!/usr/bin/env bash
set -euo pipefail

ROS_DISTRO="${ROS_DISTRO:-jazzy}"
set +u
source "/opt/ros/${ROS_DISTRO}/setup.bash"
set -u

dpkg -s ros-jazzy-xgc2-mecanum-description >/dev/null
test "$(ros2 pkg prefix mecanum_description)" = "/opt/ros/${ROS_DISTRO}"
test -f "/opt/ros/${ROS_DISTRO}/share/ament_index/resource_index/packages/mecanum_description"
test -f "/opt/ros/${ROS_DISTRO}/share/ament_index/resource_index/package_run_dependencies/mecanum_description"
test -f "/opt/ros/${ROS_DISTRO}/share/ament_index/resource_index/parent_prefix_path/mecanum_description"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/meshes/nexus_base_link.STL"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/meshes/mecanum_wheel_left.STL"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/meshes/mecanum_wheel_right.STL"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/urdf/mecanum_visual.urdf"

echo "Installed package check passed"
