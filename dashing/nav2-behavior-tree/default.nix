
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, nav2-common, behaviortree-cpp, rclcpp-action, lifecycle-msgs, geometry-msgs, ament-cmake-pytest, ament-cmake-gtest, launch, nav2-util, rclcpp, builtin-interfaces, std-srvs, rclcpp-lifecycle, tf2-geometry-msgs, tf2-ros, nav-msgs, std-msgs, ament-lint-common, launch-testing, nav2-msgs, tf2, ament-lint-auto }:
buildRosPackage {
  pname = "ros-dashing-nav2-behavior-tree";
  version = "0.2.6-r1";

  src = fetchurl {
    url = "https://github.com/SteveMacenski/navigation2-release/archive/release/dashing/nav2_behavior_tree/0.2.6-1.tar.gz";
    name = "0.2.6-1.tar.gz";
    sha256 = "df5dd5481d273c998f710fb5f46393db784d6206b5d8d36cbc54ac0ea94ecd96";
  };

  buildType = "ament_cmake";
  buildInputs = [ builtin-interfaces std-srvs rclcpp-lifecycle tf2-geometry-msgs nav2-msgs nav2-util tf2-ros nav2-common tf2 nav-msgs behaviortree-cpp rclcpp-action lifecycle-msgs rclcpp std-msgs geometry-msgs ];
  checkInputs = [ ament-cmake-pytest ament-lint-common launch-testing ament-cmake-gtest launch ament-lint-auto ];
  propagatedBuildInputs = [ builtin-interfaces std-srvs rclcpp-lifecycle tf2-geometry-msgs nav2-msgs nav2-util tf2-ros tf2 nav-msgs behaviortree-cpp rclcpp-action lifecycle-msgs rclcpp std-msgs geometry-msgs ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''TODO'';
    license = with lib.licenses; [ asl20 ];
  };
}
