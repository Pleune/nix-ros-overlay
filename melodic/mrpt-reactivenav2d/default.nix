
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, mrpt-bridge, actionlib-msgs, tf, catkin, mrpt1, visualization-msgs, actionlib, dynamic-reconfigure, roscpp, geometry-msgs }:
buildRosPackage {
  pname = "ros-melodic-mrpt-reactivenav2d";
  version = "0.1.26-r1";

  src = fetchurl {
    url = "https://github.com/mrpt-ros-pkg-release/mrpt_navigation-release/archive/release/melodic/mrpt_reactivenav2d/0.1.26-1.tar.gz";
    name = "0.1.26-1.tar.gz";
    sha256 = "6c7352f0b6f9eda20e956b30797e10bb40b0aa1ba0a22be33a872f5d3a2eb47a";
  };

  buildType = "catkin";
  buildInputs = [ actionlib-msgs roscpp mrpt1 actionlib visualization-msgs dynamic-reconfigure mrpt-bridge tf geometry-msgs ];
  propagatedBuildInputs = [ actionlib-msgs roscpp mrpt1 actionlib visualization-msgs dynamic-reconfigure mrpt-bridge tf geometry-msgs ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''Reactive navigation for 2D robots using MRPT navigation algorithms (TP-Space)'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
