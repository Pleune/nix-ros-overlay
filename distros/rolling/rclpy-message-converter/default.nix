
# Copyright 2022 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-pep257, builtin-interfaces, geometry-msgs, python3Packages, pythonPackages, rclpy, rclpy-message-converter-msgs, rosidl-default-generators, rosidl-parser, rosidl-runtime-py, std-msgs, std-srvs, tf2-msgs }:
buildRosPackage {
  pname = "ros-rolling-rclpy-message-converter";
  version = "2.0.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rospy_message_converter-release/archive/release/rolling/rclpy_message_converter/2.0.1-1.tar.gz";
    name = "2.0.1-1.tar.gz";
    sha256 = "6e5a0d0795d186f6f81dca8121ab96a9329c49a988e82a2e5390a83a3db4638b";
  };

  buildType = "ament_python";
  buildInputs = [ builtin-interfaces rosidl-default-generators ];
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 geometry-msgs pythonPackages.pytest rclpy-message-converter-msgs std-msgs std-srvs tf2-msgs ];
  propagatedBuildInputs = [ python3Packages.numpy rclpy rosidl-parser rosidl-runtime-py ];

  meta = {
    description = ''Converts between Python dictionaries and JSON to rclpy messages.'';
    license = with lib.licenses; [ asl20 ];
  };
}
