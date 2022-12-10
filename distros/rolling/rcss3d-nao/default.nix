
# Copyright 2022 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-cmake-gtest, ament-lint-auto, ament-lint-common, geometry-msgs, nao-command-msgs, nao-sensor-msgs, rclcpp-components, rcss3d-agent, rcss3d-agent-msgs-to-soccer-interfaces, soccer-vision-3d-msgs }:
buildRosPackage {
  pname = "ros-rolling-rcss3d-nao";
  version = "0.1.1-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rcss3d_nao-release/archive/release/rolling/rcss3d_nao/0.1.1-1.tar.gz";
    name = "0.1.1-1.tar.gz";
    sha256 = "438571fa12e46dc4e3fd3da364541e9ca1d229a453439a46d62e158dc65dd76b";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto ament-lint-common ];
  propagatedBuildInputs = [ geometry-msgs nao-command-msgs nao-sensor-msgs rclcpp-components rcss3d-agent rcss3d-agent-msgs-to-soccer-interfaces soccer-vision-3d-msgs ];
  nativeBuildInputs = [ ament-cmake ];

  meta = {
    description = ''An interface to SimSpark that uses interfaces used by a Nao robot'';
    license = with lib.licenses; [ asl20 ];
  };
}
