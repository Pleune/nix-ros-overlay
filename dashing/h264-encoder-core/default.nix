
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-gmock, ament-cmake-gtest, ffmpeg, aws-common, cmake }:
buildRosPackage {
  pname = "ros-dashing-h264-encoder-core";
  version = "2.0.1-r1";

  src = fetchurl {
    url = "https://github.com/aws-gbp/h264_encoder_core-release/archive/release/dashing/h264_encoder_core/2.0.1-1.tar.gz";
    name = "2.0.1-1.tar.gz";
    sha256 = "2a39d34702af1080f41f54517d9ea611a75cc18104a73f05eb33db3ea6af85b2";
  };

  buildType = "cmake";
  buildInputs = [ aws-common ffmpeg ];
  checkInputs = [ ament-cmake-gtest ament-cmake-gmock ];
  propagatedBuildInputs = [ aws-common ffmpeg ];
  nativeBuildInputs = [ cmake ];

  meta = {
    description = ''Common base code for ROS1/ROS2 H264 encoder node'';
    license = with lib.licenses; [ lgpl21 ];
  };
}