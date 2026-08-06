# XGC2 Mecanum Description

Reusable ROS 2 Jazzy visual assets for the XGC2 four-wheel Mecanum UGV.

This package owns the vehicle meshes and a visual URDF. It contains no Gazebo
plugin, controller, collision model, command topic, or simulation behavior.
Both the generic robot visualizer and Gazebo simulation consume these assets.

## Package

- ROS package: `mecanum_description`
- Debian package: `ros-jazzy-xgc2-mecanum-description`
- Visual URDF: `urdf/mecanum_visual.urdf`

The STL meshes are authored in millimetres, so consumers use a scale of
`0.001` in each axis.
