
# Copyright 2024 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, ament-cmake, cv-bridge, freeglut, geometry-msgs, glew, image-transport, mapviz-interfaces, marti-common-msgs, pkg-config, pluginlib, qt5, rclcpp, ros-environment, rqt-gui, rqt-gui-cpp, std-srvs, swri-math-util, swri-transform-util, tf2, tf2-geometry-msgs, tf2-ros, xorg, yaml-cpp }:
buildRosPackage {
  pname = "ros-jazzy-mapviz";
  version = "2.3.0-r3";

  src = fetchurl {
    url = "https://github.com/ros2-gbp/mapviz-release/archive/release/jazzy/mapviz/2.3.0-3.tar.gz";
    name = "2.3.0-3.tar.gz";
    sha256 = "05966d49ce841489a1e12cf85031af09f0ab54d56dad7b6088aa0da8280eb6ee";
  };

  buildType = "ament_cmake";
  buildInputs = [ ament-cmake pkg-config ros-environment ];
  propagatedBuildInputs = [ cv-bridge freeglut geometry-msgs glew image-transport mapviz-interfaces marti-common-msgs pluginlib qt5.qtbase rclcpp rqt-gui rqt-gui-cpp std-srvs swri-math-util swri-transform-util tf2 tf2-geometry-msgs tf2-ros xorg.libXi xorg.libXmu yaml-cpp ];
  nativeBuildInputs = [ ament-cmake pkg-config qt5.qtbase ];

  meta = {
    description = "mapviz";
    license = with lib.licenses; [ bsdOriginal ];
  };
}