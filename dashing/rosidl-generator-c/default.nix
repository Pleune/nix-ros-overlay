
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, ament-lint-common, rosidl-typesupport-interface, ament-lint-auto, ament-cmake-gtest, rosidl-cmake, rosidl-parser, ament-cmake-ros }:
buildRosPackage {
  pname = "ros-dashing-rosidl-generator-c";
  version = "0.7.7-r1";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/rosidl-release/archive/release/dashing/rosidl_generator_c/0.7.7-1.tar.gz";
    name = "0.7.7-1.tar.gz";
    sha256 = "25adb52d1e59d62d0ab9d75ccaf6937b610364f562f915fa251afbfe973b4255";
  };

  buildType = "ament_cmake";
  buildInputs = [ rosidl-typesupport-interface ];
  checkInputs = [ ament-cmake-gtest ament-lint-auto rosidl-cmake ament-lint-common ];
  propagatedBuildInputs = [ rosidl-cmake ament-cmake rosidl-typesupport-interface rosidl-parser ];
  nativeBuildInputs = [ ament-cmake-ros ];

  meta = {
    description = ''Generate the ROS interfaces in C.'';
    license = with lib.licenses; [ asl20 ];
  };
}
