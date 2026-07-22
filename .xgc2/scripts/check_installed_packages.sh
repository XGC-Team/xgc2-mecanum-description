#!/usr/bin/env bash
set -euo pipefail

ROS_DISTRO="${ROS_DISTRO:-noetic}"
source "/opt/ros/${ROS_DISTRO}/setup.bash"

dpkg -s ros-noetic-xgc2-mecanum-description >/dev/null
test "$(rospack find mecanum_description)" = "/opt/ros/${ROS_DISTRO}/share/mecanum_description"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/meshes/nexus_base_link.STL"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/meshes/mecanum_wheel_left.STL"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/meshes/mecanum_wheel_right.STL"
test -f "/opt/ros/${ROS_DISTRO}/share/mecanum_description/urdf/mecanum_visual.urdf"

echo "Installed package check passed"
