
# Copyright 2023 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-copyright, ament-flake8, ament-pep257, builtin-interfaces, python3Packages, pythonPackages, xacro }:
buildRosPackage {
  pname = "ros-rolling-webots-ros2-importer";
  version = "2023.0.0-r3";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/webots_ros2-release/archive/release/rolling/webots_ros2_importer/2023.0.0-3.tar.gz";
    name = "2023.0.0-3.tar.gz";
    sha256 = "b1cc85c7ffc9ad9e317ab1fc3674882b2edfa475a7956373a21465cdf925065d";
  };

  buildType = "ament_python";
  checkInputs = [ ament-copyright ament-flake8 ament-pep257 python3Packages.numpy python3Packages.pillow python3Packages.pycodestyle pythonPackages.pytest ];
  propagatedBuildInputs = [ builtin-interfaces python3Packages.lark python3Packages.pycollada xacro ];

  meta = {
    description = ''This package allows to convert URDF and XACRO files into Webots PROTO files.'';
    license = with lib.licenses; [ asl20 ];
  };
}