#!/usr/bin/env bash
set -euo pipefail

grep -q '^id: xgc2-mecanum-description$' .xgc2/product.yml
grep -q '^version: 0.1.0-1$' .xgc2/product.yml
grep -q '<name>mecanum_description</name>' package.xml
grep -q 'ros-noetic-urdf' .xgc2/product.yml
test -f meshes/nexus_base_link.STL
test -f meshes/wheel_shaft.STL
test -f meshes/mecanum_wheel_left.STL
test -f meshes/mecanum_wheel_right.STL
test -f meshes/urm04.STL
test -f urdf/mecanum_visual.urdf

echo "Package compliance checks passed."
