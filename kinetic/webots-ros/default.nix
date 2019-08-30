
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, tf, sensor-msgs, catkin, message-generation, message-runtime, rospy, std-msgs, roscpp }:
buildRosPackage {
  pname = "ros-kinetic-webots-ros";
  version = "2.0.5-r1";

  src = fetchurl {
    url = https://github.com/cyberbotics/webots_ros-release/archive/release/kinetic/webots_ros/2.0.5-1.tar.gz;
    sha256 = "599d07fccbf6377bd4785b8b2632b6485a7b1ec5f919ccdf5f5b10fa8eee80c6";
  };

  buildInputs = [ sensor-msgs roscpp message-generation rospy std-msgs tf ];
  propagatedBuildInputs = [ sensor-msgs roscpp message-runtime rospy std-msgs tf ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''The ROS package containing examples for interfacing ROS with the standard ROS controller of Webots'';
    license = with lib.licenses; [ asl20 ];
  };
}
