
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, class-loader, catkin, canopen-master, rosunit }:
buildRosPackage {
  pname = "ros-melodic-canopen-402";
  version = "0.8.2-r1";

  src = fetchurl {
    url = "https://github.com/ros-industrial-release/ros_canopen-release/archive/release/melodic/canopen_402/0.8.2-1.tar.gz";
    name = "0.8.2-1.tar.gz";
    sha256 = "6292ad50cab1fafeeb44ec195871040a5d694ce80eab76635fa5c15054801da0";
  };

  buildType = "catkin";
  buildInputs = [ class-loader canopen-master ];
  checkInputs = [ rosunit ];
  propagatedBuildInputs = [ class-loader canopen-master ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''This implements the CANopen device profile for drives and motion control. CiA(r) 402'';
    license = with lib.licenses; [ lgpl2 ];
  };
}
