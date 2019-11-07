
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, genmsg, catkin }:
buildRosPackage {
  pname = "ros-melodic-roslang";
  version = "1.14.7-r1";

  src = fetchurl {
    url = "https://github.com/ros-gbp/ros-release/archive/release/melodic/roslang/1.14.7-1.tar.gz";
    name = "1.14.7-1.tar.gz";
    sha256 = "2fa4021768ecf136c9203100fd0537787e06e05af215bf5f17e0fb5740e7cb90";
  };

  buildType = "catkin";
  propagatedBuildInputs = [ genmsg catkin ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''roslang is a common package that all <a href="http://www.ros.org/wiki/Client%20Libraries">ROS client libraries</a> depend on.
    This is mainly used to find client libraries (via 'rospack depends-on1 roslang').'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
