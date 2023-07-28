
# Copyright 2023 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-index-python, ament-pep257, launch, launch-ros, launch-xml, launch-yaml, pythonPackages, ros2cli, ros2pkg }:
buildRosPackage {
  pname = "ros-humble-ros2launch";
  version = "0.19.5-r2";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/launch_ros-release/archive/release/humble/ros2launch/0.19.5-2.tar.gz";
    name = "0.19.5-2.tar.gz";
    sha256 = "07a3e8b7553fd404f1b5025d49f5e67f3a74825d64d31b8f56adcaf9b1b7576d";
  };

  buildType = "ament_python";
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 pythonPackages.pytest ];
  propagatedBuildInputs = [ ament-index-python launch launch-ros launch-xml launch-yaml ros2cli ros2pkg ];

  meta = {
    description = ''The launch command for ROS 2 command line tools.'';
    license = with lib.licenses; [ asl20 ];
  };
}
