#!/usr/bin/env python3
"""Keep the lightweight viewer URDF visually aligned with the Gazebo model."""

from pathlib import Path
import unittest
import xml.etree.ElementTree as ET


PACKAGE_ROOT = Path(__file__).resolve().parents[1]
VISUAL_URDF = PACKAGE_ROOT / "urdf" / "mecanum_visual.urdf"


class MecanumVisualAssetsTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.root = ET.parse(VISUAL_URDF).getroot()
        cls.materials = {
            material.attrib["name"]: material.find("color").attrib["rgba"]
            for material in cls.root.findall("material")
        }
        cls.joints = {
            joint.attrib["name"]: joint.find("origin").attrib
            for joint in cls.root.findall("joint")
        }

    def test_gazebo_materials_are_preserved(self):
        self.assertEqual(self.materials["mecanum_body"], "0.90 0.80 0.60 1")
        self.assertEqual(self.materials["mecanum_wheel"], "0.60 0.60 0.60 1")
        self.assertEqual(self.materials["mecanum_metal"], "0.15 0.15 0.15 1")
        self.assertEqual(self.materials["mecanum_sensor"], "0.15 0.15 0.15 1")

    def test_gazebo_visual_poses_are_preserved(self):
        expected = {
            "upper_left_wheel_joint": ("0.150 0.150 0.05", "0 0 0"),
            "lower_left_wheel_joint": ("-0.150 0.150 0.05", "0 0 0"),
            "upper_right_wheel_joint": (
                "0.150 -0.150 0.05",
                "3.141592653589793 0 0",
            ),
            "lower_right_wheel_joint": (
                "-0.150 -0.150 0.05",
                "3.141592653589793 0 0",
            ),
            "upper_left_wheel_shaft_joint": ("0.150 0.108 0.05", "0 0 0"),
            "lower_left_wheel_shaft_joint": ("-0.150 0.108 0.05", "0 0 0"),
            "upper_right_wheel_shaft_joint": (
                "0.150 -0.108 0.05",
                "3.141592653589793 0 0",
            ),
            "lower_right_wheel_shaft_joint": (
                "-0.150 -0.108 0.05",
                "3.141592653589793 0 0",
            ),
            "front_sensor_joint": (
                "0.205 0 0.06",
                "1.5707963267948966 0 0",
            ),
            "left_sensor_joint": (
                "0 0.108 0.06",
                "1.5707963267948966 0 1.5707963267948966",
            ),
            "right_sensor_joint": (
                "0 -0.108 0.06",
                "1.5707963267948966 0 -1.5707963267948966",
            ),
            "rear_sensor_joint": (
                "-0.201 0 0.06",
                "1.5707963267948966 0 3.141592653589793",
            ),
        }
        for joint, (xyz, rpy) in expected.items():
            self.assertEqual(self.joints[joint]["xyz"], xyz)
            self.assertEqual(self.joints[joint]["rpy"], rpy)

        base = self.root.find("./link[@name='base_link']")
        body = next(
            visual for visual in base.findall("visual") if visual.find("geometry/mesh") is not None
        )
        self.assertEqual(body.find("origin").attrib["xyz"], "0 0 0.05")
        camera = base.find("./visual[@name='stereo_camera']")
        self.assertEqual(camera.find("origin").attrib["xyz"], "0.205 0 0.06")
        self.assertEqual(camera.find("geometry/box").attrib["size"], "0.02 0.08 0.01")

    def test_all_meshes_use_gazebo_millimetre_scale(self):
        meshes = self.root.findall(".//mesh")
        self.assertEqual(len(meshes), 13)
        for mesh in meshes:
            self.assertEqual(mesh.attrib["scale"], "0.001 0.001 0.001")


if __name__ == "__main__":
    unittest.main()
