
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, cob-moveit-config, cob-default-robot-behavior, cob-hardware-config, catkin, cob-bringup, cob-default-robot-config }:
buildRosPackage {
  pname = "ros-kinetic-cob-robots";
  version = "0.7.2-r1";

  src = fetchurl {
    url = "https://github.com/ipa320/cob_robots-release/archive/release/kinetic/cob_robots/0.7.2-1.tar.gz";
    name = "0.7.2-1.tar.gz";
    sha256 = "716759ee98d528f2366395df34db139c017e1a56e40093f25afc2cd841082f82";
  };

  buildType = "catkin";
  propagatedBuildInputs = [ cob-default-robot-behavior cob-moveit-config cob-hardware-config cob-bringup cob-default-robot-config ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''This stack holds packages for hardware configuration as well as launch files for starting up the basic layer for operating Care-O-bot.'';
    license = with lib.licenses; [ asl20 ];
  };
}
