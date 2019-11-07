
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, joint-trajectory-controller, position-controllers, cob-omni-drive-controller, cob-description, cob-supported-robots, joint-state-controller, rviz, robot-state-publisher, roslaunch, joint-state-publisher, xacro, catkin, velocity-controllers, diagnostic-aggregator, costmap-2d, raw-description, rostest, laser-filters, cob-calibration-data }:
buildRosPackage {
  pname = "ros-kinetic-cob-hardware-config";
  version = "0.7.2-r1";

  src = fetchurl {
    url = "https://github.com/ipa320/cob_robots-release/archive/release/kinetic/cob_hardware_config/0.7.2-1.tar.gz";
    name = "0.7.2-1.tar.gz";
    sha256 = "969c9f9ccc79d038be2060d3114df9fa7339849228adc3bd57bc239aa291c258";
  };

  buildType = "catkin";
  buildInputs = [ rostest roslaunch cob-supported-robots ];
  propagatedBuildInputs = [ roslaunch costmap-2d joint-state-controller raw-description velocity-controllers joint-trajectory-controller rostest position-controllers laser-filters cob-omni-drive-controller cob-description robot-state-publisher rviz diagnostic-aggregator cob-calibration-data joint-state-publisher xacro ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''This package contains configuration for each robot instance (e.g. cob4-X, raw3-X). There is a directory for each robot with configuration about urdf and hardware/device configurations.'';
    license = with lib.licenses; [ asl20 ];
  };
}
