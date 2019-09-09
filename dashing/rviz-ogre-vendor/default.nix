
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, pkg-config, xorg, libGLU, libGL, freetype }:
buildRosPackage {
  pname = "ros-dashing-rviz-ogre-vendor";
  version = "6.1.4-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rviz-release/archive/release/dashing/rviz_ogre_vendor/6.1.4-1.tar.gz";
    name = "6.1.4-1.tar.gz";
    sha256 = "b58123f893d62043ec947ce1ed627462139bb474a10ba3cbec9d8cf02e5e63c4";
  };

  buildType = "ament_cmake";
  buildInputs = [ xorg.libXaw pkg-config xorg.libXrandr xorg.libX11 libGLU libGL freetype ];
  propagatedBuildInputs = [ xorg.libXaw xorg.libXrandr xorg.libX11 libGLU libGL freetype ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''Wrapper around ogre3d, it provides a fixed CMake module and an ExternalProject build of ogre.'';
    license = with lib.licenses; [ asl20 mit ];
  };
}