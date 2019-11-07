
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, grid-map-rviz-plugin, grid-map-core, grid-map-visualization, sensor-msgs, cv-bridge, catkin, grid-map-filters, octomap-msgs, grid-map-cv, grid-map-octomap, grid-map-ros, grid-map-msgs, roscpp, grid-map-loader, geometry-msgs }:
buildRosPackage {
  pname = "ros-kinetic-grid-map-demos";
  version = "1.6.2-r1";

  src = fetchurl {
    url = "https://github.com/anybotics/grid_map-release/archive/release/kinetic/grid_map_demos/1.6.2-1.tar.gz";
    name = "1.6.2-1.tar.gz";
    sha256 = "01cbf50c1f042af1e1a17550b5e26d1321e100a94c94ea98098cfb01492a67fb";
  };

  buildType = "catkin";
  buildInputs = [ grid-map-rviz-plugin grid-map-core grid-map-visualization geometry-msgs sensor-msgs cv-bridge grid-map-filters octomap-msgs grid-map-cv grid-map-ros grid-map-msgs roscpp grid-map-loader grid-map-octomap ];
  propagatedBuildInputs = [ grid-map-rviz-plugin grid-map-core grid-map-visualization geometry-msgs sensor-msgs cv-bridge grid-map-filters octomap-msgs grid-map-octomap grid-map-ros grid-map-msgs roscpp grid-map-loader grid-map-cv ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''Demo nodes to demonstrate the usage of the grid map library.'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
