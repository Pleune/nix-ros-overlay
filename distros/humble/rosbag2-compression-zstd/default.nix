
# Copyright 2024 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gmock, ament-lint-auto, ament-lint-common, pluginlib, rclcpp, rcpputils, rcutils, rosbag2-compression, rosbag2-test-common, zstd-vendor }:
buildRosPackage {
  pname = "ros-humble-rosbag2-compression-zstd";
  version = "0.15.12-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rosbag2-release/archive/release/humble/rosbag2_compression_zstd/0.15.12-1.tar.gz";
    name = "0.15.12-1.tar.gz";
    sha256 = "c7257e9a8a3a272b59f195b663d5ef3b2f13fdf82d7a0703134dd2700b2d7bb9";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  checkInputs = [ ament-cmake-gmock ament-lint-auto ament-lint-common rclcpp rosbag2-test-common ];
  propagatedBuildInputs = [ pluginlib rcpputils rcutils rosbag2-compression zstd-vendor ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = "Zstandard compression library implementation of rosbag2_compression";
    license = with lib.licenses; [ asl20 ];
  };
}
