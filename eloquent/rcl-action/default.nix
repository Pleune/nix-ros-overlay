
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake-ros, rcutils, rmw-implementation-cmake, rcl, ament-lint-common, test-msgs, ament-cmake-gtest, osrf-testing-tools-cpp, rmw, rosidl-generator-c, action-msgs, ament-lint-auto }:
buildRosPackage {
  pname = "ros-eloquent-rcl-action";
  version = "0.8.3-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rcl-release/archive/release/eloquent/rcl_action/0.8.3-1.tar.gz";
    name = "0.8.3-1.tar.gz";
    sha256 = "cdc7d21298ac5551d8212bae291fdb774cba6bb67dc9587a5aa5ec7565d97937";
  };

  buildType = "ament_cmake";
  buildInputs = [ rcutils rcl rmw rosidl-generator-c action-msgs ];
  checkInputs = [ rmw-implementation-cmake ament-lint-common ament-lint-auto test-msgs osrf-testing-tools-cpp ament-cmake-gtest ];
  propagatedBuildInputs = [ rcutils rcl rmw rosidl-generator-c action-msgs ];
  nativeBuildInputs = [ ament-cmake-ros ];

  meta = {
    description = ''Package containing a C-based ROS action implementation'';
    license = with lib.licenses; [ asl20 ];
  };
}