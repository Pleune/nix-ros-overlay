
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, gazebo-ros, catkin, eigen }:
buildRosPackage {
  pname = "ros-kinetic-wave-gazebo-plugins";
  version = "1.2.0-r1";

  src = fetchurl {
    url = https://github.com/ros-gbp/vrx-release/archive/release/kinetic/wave_gazebo_plugins/1.2.0-1.tar.gz;
    sha256 = "9ad6c3e89c30c5cba93be9c6891ece818ae2bdd393f73bf18373bf67f6405a0a";
  };

  buildInputs = [ gazebo-ros eigen ];
  propagatedBuildInputs = [ gazebo-ros ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''This package contains Gazebo plugins for the simulation of 
    water surface waves and hydrostatic and hydrodynamics forces.'';
    license = with lib.licenses; [ "TBD" ];
  };
}
