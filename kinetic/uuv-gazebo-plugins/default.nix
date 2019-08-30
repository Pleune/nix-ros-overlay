
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin, gazebo-dev, eigen, protobuf, rosunit }:
buildRosPackage {
  pname = "ros-kinetic-uuv-gazebo-plugins";
  version = "0.6.13";

  src = fetchurl {
    url = https://github.com/uuvsimulator/uuv_simulator-release/archive/release/kinetic/uuv_gazebo_plugins/0.6.13-0.tar.gz;
    sha256 = "a6e14978fcb1730063e8f7e84d203e6930ee85fd3f65e567f200565afdf0cdc1";
  };

  buildInputs = [ protobuf eigen gazebo-dev ];
  checkInputs = [ rosunit ];
  propagatedBuildInputs = [ protobuf eigen gazebo-dev ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''UUV Simulator's Gazebo plugins for simulation of hydrodynamic and hydrostatic
    forces, and underwater actuators (e.g. thrusters and fins).'';
    license = with lib.licenses; [ asl20 ];
  };
}
