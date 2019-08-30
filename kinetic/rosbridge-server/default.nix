
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, rosapi, catkin, pythonPackages, rosbridge-library, rosauth, rospy, rosbridge-msgs }:
buildRosPackage {
  pname = "ros-kinetic-rosbridge-server";
  version = "0.11.3-r1";

  src = fetchurl {
    url = https://github.com/RobotWebTools-release/rosbridge_suite-release/archive/release/kinetic/rosbridge_server/0.11.3-1.tar.gz;
    sha256 = "2cfe8c0047ca4c87629b47fb25429aba6b6fe718d49209f5c168fd3af88049a6";
  };

  propagatedBuildInputs = [ rosapi pythonPackages.backports_ssl_match_hostname rosbridge-library pythonPackages.twisted rosauth rospy rosbridge-msgs pythonPackages.tornado ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''A WebSocket interface to rosbridge.'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
