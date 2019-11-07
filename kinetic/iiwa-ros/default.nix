
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, iiwa-msgs, catkin, cmake-modules, roscpp }:
buildRosPackage {
  pname = "ros-kinetic-iiwa-ros";
  version = "1.4.1-r1";

  src = fetchurl {
    url = "https://github.com/ipa-rwu/iiwa_stack-release/archive/release/kinetic/iiwa_ros/1.4.1-1.tar.gz";
    name = "1.4.1-1.tar.gz";
    sha256 = "0da94fb4366ddb8fcf9f7e3b8b3a4eeb1b3eb208cea6dd3abc0065be1a5fd0c6";
  };

  buildType = "catkin";
  buildInputs = [ iiwa-msgs roscpp cmake-modules ];
  propagatedBuildInputs = [ iiwa-msgs roscpp cmake-modules ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''The iiwa_ros package'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
