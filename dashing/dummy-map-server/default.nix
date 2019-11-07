
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, ament-cmake-gtest, nav-msgs, rclcpp, ament-lint-auto }:
buildRosPackage {
  pname = "ros-dashing-dummy-map-server";
  version = "0.7.9-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/demos-release/archive/release/dashing/dummy_map_server/0.7.9-1.tar.gz";
    name = "0.7.9-1.tar.gz";
    sha256 = "335bf15cdee40abed22bbcb92501a400189a7db49b419842fdd4f7eb0a104eca";
  };

  buildType = "ament_cmake";
  buildInputs = [ nav-msgs rclcpp ];
  checkInputs = [ ament-lint-auto ament-cmake-gtest ament-lint-common ];
  propagatedBuildInputs = [ nav-msgs rclcpp ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''dummy map server node'';
    license = with lib.licenses; [ asl20 ];
  };
}
