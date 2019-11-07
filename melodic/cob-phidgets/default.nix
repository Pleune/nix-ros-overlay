
# Copyright 2019 Open Source Robotics Foundation
# Distributed under the terms of the BSD license

{ lib, buildRosPackage, fetchurl, sensor-msgs, catkin, message-generation, message-runtime, libphidgets, rospy, std-msgs, roscpp }:
buildRosPackage {
  pname = "ros-melodic-cob-phidgets";
  version = "0.7.1-r1";

  src = fetchurl {
    url = "https://github.com/ipa320/cob_driver-release/archive/release/melodic/cob_phidgets/0.7.1-1.tar.gz";
    name = "0.7.1-1.tar.gz";
    sha256 = "8b0223f8f93a58d2c702abb0733ac88b6d18528014a1b89fc9c52ee7cbf77f81";
  };

  buildType = "catkin";
  buildInputs = [ sensor-msgs message-generation libphidgets std-msgs roscpp ];
  propagatedBuildInputs = [ sensor-msgs message-runtime libphidgets rospy std-msgs roscpp ];
  nativeBuildInputs = [ catkin ];

  meta = {
    description = ''cob_phidgets'';
    license = with lib.licenses; [ asl20 ];
  };
}
