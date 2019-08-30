
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, rqt-gui-py, sensor-msgs, rqt-gui, catkin, pythonPackages, rospy, roslib, geometry-msgs }:
buildRosPackage {
  pname = "ros-kinetic-rqt-drone-teleop";
  version = "1.0.1-r1";

  src = fetchurl {
    url = https://github.com/JdeRobot/drones-release/archive/release/kinetic/rqt_drone_teleop/1.0.1-1.tar.gz;
    sha256 = "ab6fb9502cd02df0777feecf745153c2949622dc1ec7c4efe2cb8ea392ad3743";
  };

  buildInputs = [ rqt-gui-py pythonPackages.rospkg sensor-msgs rqt-gui rospy roslib geometry-msgs ];
  propagatedBuildInputs = [ rqt-gui-py pythonPackages.rospkg sensor-msgs rqt-gui rospy roslib geometry-msgs ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''A common drone teleop interface for all drone exercises in the JdeRobot Robotics Academy'';
    license = with lib.licenses; [ mit ];
  };
}
