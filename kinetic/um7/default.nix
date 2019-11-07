
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, roslint, sensor-msgs, catkin, serial, message-generation, message-runtime, roscpp }:
buildRosPackage {
  pname = "ros-kinetic-um7";
  version = "0.0.6-r1";

  src = fetchurl {
    url = "https://github.com/ros-drivers-gbp/um7-release/archive/release/kinetic/um7/0.0.6-1.tar.gz";
    name = "0.0.6-1.tar.gz";
    sha256 = "b5f49ee4c0dcb8f24c678ad52c7443ff3b685633fabaaa1febfc02d1826faa18";
  };

  buildType = "catkin";
  buildInputs = [ roscpp sensor-msgs message-generation serial ];
  checkInputs = [ roslint ];
  propagatedBuildInputs = [ sensor-msgs roscpp message-runtime serial ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''The um7 package provides a C++ implementation of the CH Robotics serial protocol, and a
    corresponding ROS node for publishing standard ROS orientation topics from a UM7.'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
