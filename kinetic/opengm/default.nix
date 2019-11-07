
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, catkin }:
buildRosPackage {
  pname = "ros-kinetic-opengm";
  version = "0.6.14-r1";

  src = fetchurl {
    url = "https://github.com/ipa320/cob_extern-release/archive/release/kinetic/opengm/0.6.14-1.tar.gz";
    name = "0.6.14-1.tar.gz";
    sha256 = "1b48790841007f83af24c48cdae4122cf4c62fdff326f91fee1ea922f88ba305";
  };

  buildType = "catkin";
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''This package wraps the external c++ library opengm in a ROS package, so other packages can use it. It downloads the source code of it and then unzips it. The library is a header-only library with command line interfaces, which aren't used, so it doesn't gets build. For further descriptions and tutorials see the Makefile.tarball and https://github.com/opengm/opengm .
		Copyright (C) 2013 Bjoern Andres, Thorsten Beier and Joerg H.~Kappes.'';
    license = with lib.licenses; [ mit ];
  };
}
