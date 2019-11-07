
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, mrpt-rbpf-slam, mrpt-icp-slam-2d, catkin, mrpt-ekf-slam-2d, mrpt-ekf-slam-3d, mrpt-graphslam-2d }:
buildRosPackage {
  pname = "ros-melodic-mrpt-slam";
  version = "0.1.10-r1";

  src = fetchurl {
    url = "https://github.com/mrpt-ros-pkg-release/mrpt_slam-release/archive/release/melodic/mrpt_slam/0.1.10-1.tar.gz";
    name = "0.1.10-1.tar.gz";
    sha256 = "cd4cceb5206c92510212ad222c8d3084d4513fa2426331273b2ed9cf17b17625";
  };

  buildType = "catkin";
  propagatedBuildInputs = [ mrpt-icp-slam-2d mrpt-rbpf-slam mrpt-ekf-slam-2d mrpt-ekf-slam-3d mrpt-graphslam-2d ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''mrpt_slam'';
    license = with lib.licenses; [ bsdOriginal ];
  };
}
