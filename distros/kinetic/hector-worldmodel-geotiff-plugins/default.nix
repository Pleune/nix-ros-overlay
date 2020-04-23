
# Copyright 2020 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin, hector-geotiff, hector-worldmodel-msgs }:
buildRosPackage {
  pname = "ros-kinetic-hector-worldmodel-geotiff-plugins";
  version = "0.3.4";

  src = fetchurl {
    url = "https://github.com/tu-darmstadt-ros-pkg-gbp/hector_worldmodel-release/archive/release/kinetic/hector_worldmodel_geotiff_plugins/0.3.4-0.tar.gz";
    name = "0.3.4-0.tar.gz";
    sha256 = "68aa6355f7c39c11ad20cdc7ce8129f6c4fb4bf9710105b1e76c2214395701d1";
  };

  buildType = "catkin";
  propagatedBuildInputs = [ hector-geotiff hector-worldmodel-msgs ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''hector_worldmodel_geotiff_plugins contains a plugin to visualize worldmodel objects (e.g. victims in a
     Search and Rescue scenario) in a geotiff map generated by <a href="http://wiki.ros.org/hector_geotiff">hector_geotiff</a>.'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}