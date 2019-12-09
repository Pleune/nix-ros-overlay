
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, xacro, raw-description, cob-calibration-data, rostest, joint-state-controller, laser-filters, robot-state-publisher, position-controllers, joint-trajectory-controller, cob-supported-robots, joint-state-publisher, diagnostic-aggregator, catkin, costmap-2d, roslaunch, cob-omni-drive-controller, rviz, cob-description, velocity-controllers }:
buildRosPackage {
  pname = "ros-melodic-cob-hardware-config";
  version = "0.7.2-r1";

  src = fetchurl {
    url = "https://github.com/ipa320/cob_robots-release/archive/release/melodic/cob_hardware_config/0.7.2-1.tar.gz";
    name = "0.7.2-1.tar.gz";
    sha256 = "a2771fecd349087dd110e05334e978a7b179e53d860a1f926b4f18f61a19fc61";
  };

  buildType = "catkin";
  buildInputs = [ cob-supported-robots roslaunch rostest ];
  propagatedBuildInputs = [ diagnostic-aggregator joint-state-publisher xacro laser-filters robot-state-publisher raw-description position-controllers velocity-controllers cob-omni-drive-controller cob-calibration-data costmap-2d rviz cob-description joint-trajectory-controller roslaunch rostest joint-state-controller ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''This package contains configuration for each robot instance (e.g. cob4-X, raw3-X). There is a directory for each robot with configuration about urdf and hardware/device configurations.'';
    license = with lib.licenses; [ asl20 ];
  };
}