
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-xmllint, ament-flake8, pythonPackages, ament-pep257, ament-copyright, ros2pkg, ros2cli }:
buildRosPackage {
  pname = "ros-dashing-ros2run";
  version = "0.7.7-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/ros2cli-release/archive/release/dashing/ros2run/0.7.7-1.tar.gz";
    name = "0.7.7-1.tar.gz";
    sha256 = "69f445dd7deea23957f9c58fbe0888ef6cee8075f40851e595ae24a0ccbf055a";
  };

  buildType = "ament_python";
  buildInputs = [ ros2cli ];
  checkInputs = [ ament-xmllint ament-flake8 pythonPackages.pytest ament-pep257 ament-copyright ];
  propagatedBuildInputs = [ ros2pkg ros2cli ];

  meta = {
    description = ''The run command for ROS 2 command line tools.'';
    license = with lib.licenses; [ asl20 ];
  };
}
