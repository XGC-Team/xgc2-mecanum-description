#!/usr/bin/env bash
set -euo pipefail

grep -q '^id: xgc2-mecanum-description$' .xgc2/product.yml
grep -q '^version: 0.1.0-4$' .xgc2/product.yml
grep -q '<name>mecanum_description</name>' package.xml
grep -q 'ros-noetic-urdf' .xgc2/product.yml
test -f meshes/nexus_base_link.STL
test -f meshes/wheel_shaft.STL
test -f meshes/mecanum_wheel_left.STL
test -f meshes/mecanum_wheel_right.STL
test -f meshes/urm04.STL
test -f urdf/mecanum_visual.urdf

expected_hashes="$(mktemp)"
actual_hashes="$(mktemp)"
trap 'rm -f "${expected_hashes}" "${actual_hashes}"' EXIT
printf '%s  %s\n' \
  d7dca9423f8aedcf5abb47719902c7dc9567b35e80d9ffc8a1d7bd3b291dd3bd meshes/mecanum_wheel_left.STL \
  e72c8900c97374263bdc2e2cf3514ae93030748a2f5492edb1194dbd561c1222 meshes/mecanum_wheel_right.STL \
  ff55045432ca4546e7084bb2fc6a2f44ac34cb5510922193ee59c6aa9069fc14 meshes/nexus_base_link.STL \
  9bdfc9589c6d00bb19ae6584a3b5264dd6bb92a36d5e5ce66c18272bb8d5ae3c meshes/urm04.STL \
  82a1b42d2659942ac90a3237542e68c498fac0948d2ae98749ecc2295d328b94 meshes/wheel_shaft.STL >"${expected_hashes}"
sha256sum meshes/*.STL | sort >"${actual_hashes}"
sort -o "${expected_hashes}" "${expected_hashes}"
diff -u "${expected_hashes}" "${actual_hashes}"

echo "Package compliance checks passed."
