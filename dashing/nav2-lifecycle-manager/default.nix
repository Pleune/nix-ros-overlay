
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, std-srvs, ament-cmake, ament-lint-common, rclcpp-lifecycle, tf2-geometry-msgs, nav2-msgs, nav2-util, nav2-common, lifecycle-msgs, rclcpp-action, std-msgs, ament-lint-auto, geometry-msgs }:
buildRosPackage {
  pname = "ros-dashing-nav2-lifecycle-manager";
  version = "0.2.6-r1";

  src = fetchurl {
    url = "https://github.com/SteveMacenski/navigation2-release/archive/release/dashing/nav2_lifecycle_manager/0.2.6-1.tar.gz";
    name = "0.2.6-1.tar.gz";
    sha256 = "e1f444ebf49e6c4e7481d32ee37851b00f23868a11b48bf039a38679fa1df031";
  };

  buildType = "ament_cmake";
  buildInputs = [ std-srvs rclcpp-lifecycle tf2-geometry-msgs nav2-msgs nav2-util nav2-common lifecycle-msgs rclcpp-action std-msgs geometry-msgs ];
  checkInputs = [ ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ std-srvs rclcpp-lifecycle tf2-geometry-msgs nav2-msgs nav2-util lifecycle-msgs rclcpp-action std-msgs geometry-msgs ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''A controller/manager for the lifecycle nodes of the Navigation 2 system'';
    license = with lib.licenses; [ asl20 ];
  };
}
