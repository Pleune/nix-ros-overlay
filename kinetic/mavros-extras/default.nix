
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, cmake-modules, sensor-msgs, catkin, mavros, roscpp, urdf, visualization-msgs, tf2-eigen, std-msgs, tf, mavros-msgs, geometry-msgs }:
buildRosPackage {
  pname = "ros-kinetic-mavros-extras";
  version = "0.33.0-r1";

  src = fetchurl {
    url = "https://github.com/mavlink/mavros-release/archive/release/kinetic/mavros_extras/0.33.0-1.tar.gz";
    name = "0.33.0-1.tar.gz";
    sha256 = "277d3db0ae3319b9b33b4dc4c88674f8f706050a974073673152c8fd07c0db17";
  };

  buildType = "catkin";
  buildInputs = [ cmake-modules sensor-msgs mavros roscpp urdf tf2-eigen visualization-msgs std-msgs tf mavros-msgs geometry-msgs ];
  propagatedBuildInputs = [ sensor-msgs mavros roscpp urdf tf2-eigen visualization-msgs std-msgs tf mavros-msgs geometry-msgs ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''Extra nodes and plugins for <a href="http://wiki.ros.org/mavros">MAVROS</a>.'';
    license = with lib.licenses; [ gpl3 lgpl2 bsdOriginal ];
  };
}
