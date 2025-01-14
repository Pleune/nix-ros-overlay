{ version, distro, python }:
self: super:
let
  pythonOverridesFor = with self.lib; prevPython: prevPython // {
    pkgs = prevPython.pkgs.overrideScope (pyFinal: pyPrev: {
      wxPython = pyFinal.wxPython_4_2;

      # ROS is not compatible with empy 4
      empy = pyFinal.empy_3;
    });
  };

  base = rosSelf: rosSuper: {
    recurseForDerivations = true;
    lib = super.lib // import ../lib { inherit self rosSelf; };

    callPackage = self.newScope rosSelf;

    buildRosPackage = rosSelf.callPackage ./build-ros-package {
      rosVersion = version;
      rosDistro = distro;
    };

    buildEnv = rosSelf.callPackage ./build-env {
      inherit (self) buildEnv;
    };

    python = pythonOverridesFor python;
    pythonPackages = rosSelf.python.pkgs;

    python3 = pythonOverridesFor self.python3;
    python3Packages = rosSelf.python3.pkgs;

    boost = self.boost.override {
      python = rosSelf.python;
      enablePython = true;
    };
  };

  overrides = rosSelf: rosSuper: with rosSelf.lib; {
    # ROS package overrides/fixups

    camera-calibration-parsers = patchBoostPython rosSuper.camera-calibration-parsers;

    cob-light = patchBoostSignals rosSuper.cob-light;

    cv-bridge = patchBoostPython rosSuper.cv-bridge;

    dynamic-reconfigure = rosSuper.dynamic-reconfigure.overrideAttrs ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + ''
        substituteInPlace cmake/setup_custom_pythonpath.sh.in \
          --replace '#!/usr/bin/env sh' '#!${self.stdenv.shell}'
      '';
    });

    fake-localization = patchBoostSignals rosSuper.fake-localization;

    gazebo-ros = rosSuper.gazebo-ros.overrideAttrs ({ ... }:{
      setupHook = ./gazebo-ros-setup-hook.sh;
    });

    gmapping = patchBoostSignals rosSuper.gmapping;

    image-cb-detector = patchBoostSignals rosSuper.image-cb-detector;

    laser-cb-detector = patchBoostSignals rosSuper.laser-cb-detector;

    libfranka = rosSuper.libfranka.overrideAttrs ({
      cmakeFlags ? [], ...
    }: {
      # Uses custom flag to disable tests. Attempts to download GTest without
      # this.
      cmakeFlags = cmakeFlags ++ [ "-DBUILD_TESTS=OFF" ];
    });

    libpcan = patchVendorUrl rosSuper.libpcan {
      url = "http://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-8.3.tar.gz";
      sha256 = "0f6v3vjszyg1xp99jx48hyv8p32iyq4j18a4ir4x5p6f3b0z3r34";
    };

    librealsense = rosSuper.librealsense.overrideAttrs ({
      patches ? [], ...
    }: {
      patches = patches ++ [ (self.fetchpatch {
        url = "https://github.com/IntelRealSense/librealsense/commit/86e434c86096b91a722f22bd039c2b6eeb8174ab.patch";
        sha256 = "1kcvm32cx9zzd56k9yglnyxizmfgar3a6cybjdwpyf6ljrxjlpp5";
      }) ];
    });

    librealsense2 = rosSuper.librealsense2.overrideAttrs ({
      buildInputs ? [], ...
    }: {
      buildInputs = buildInputs ++ [ self.glfw self.libGLU ];
    });

    libuvc-camera = rosSuper.libuvc-camera.overrideAttrs ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + ''
        substituteInPlace cfg/UVCCamera.cfg --replace python2 python
      '';
    });

    mapviz = rosSuper.mapviz.overrideAttrs ({
      nativeBuildInputs ? [],
      postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/mapviz/mapviz"
      '';
    });

    mavlink = rosSuper.mavlink.overrideAttrs ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + ''
        substituteInPlace CMakeLists.txt --replace /usr/bin/env '${self.buildPackages.coreutils}/bin/env'
        patchShebangs pymavlink/tools/mavgen.py
      '';
      ROS_PYTHON_VERSION = if rosSelf.python.isPy3k then 3 else 2;
    });

    message-filters = patchBoostSignals rosSuper.message-filters;

    message-relay = rosSuper.message-relay.overrideAttrs ({
      postPatch ? "", ...
    }: {
      postPatch = postPatch + ''
        patchShebangs scripts
      '';
    });

    novatel-oem7-driver = (patchExternalProjectGit rosSuper.novatel-oem7-driver {
      url = "https://github.com/novatel/novatel_edie";
      fetchgitArgs = {
        rev = "d02ccc2dfe531d642c1e2ca8a8c0f8205c856f23";
        hash = "sha256-ZQ7z9vQ8quI+SoNhB93tTw5LQe07UAKdbJJpaMj1C6I=";
      };
    }).overrideAttrs ({ ... }: {
      dontFixCmake = true;
    });

    ompl = rosSuper.ompl.overrideAttrs ({
      patches ? [], ...
    }: {
      patches = patches ++ [
        # Fix pkg-config paths
        (self.fetchpatch {
          url = "https://github.com/ompl/ompl/commit/d4e26fc3d86cae0c36941a10bf0307e02526db44.patch";
          hash = "sha256-sAQLrWHoR/DhHk8TtUEy8E8VXqrvtXl2BGS5UvElJl8=";
        })
      ];
    });

    open-manipulator-control-gui = rosSuper.open-manipulator-control-gui.overrideAttrs ({
      nativeBuildInputs ? [], ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = ''
        wrapQtApp "$out/lib/open_manipulator_control_gui/open_manipulator_control_gui"
      '';
    });

    plotjuggler = rosSuper.plotjuggler.overrideAttrs ({
      nativeBuildInputs ? [], ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = ''
        wrapQtApp "$out/lib/plotjuggler/plotjuggler"
      '';
    });

    pr2-tilt-laser-interface = patchBoostSignals rosSuper.pr2-tilt-laser-interface;

    python-qt-binding = (rosSuper.python-qt-binding.override {
      python3Packages = rosSelf.python3Packages.overrideScope (pyFinal: pyPrev: {
        pyqt5 = pyPrev.pyqt5.overrideAttrs ({
          patches ? [], ...
        }: {
          patches = patches ++ [ (self.fetchpatch {
            url = "https://aur.archlinux.org/cgit/aur.git/plain/restore-sip4-support.patch?h=python-pyqt5-sip4&id=6e712e6c588d550a1a6f83c1b37c2c9135aae6ba";
            hash = "sha256-NfMe/EK1Uj88S82xZSm+A6js3PK9mlgsaci/kinlsy8=";
          }) ];
        });
      });
    }).overrideAttrs ({
      propagatedBuildInputs ? [], ...
    }: {
      propagatedBuildInputs = propagatedBuildInputs ++ (with rosSelf.pythonPackages; [
        shiboken2
        pyside2
        sip4
      ]);

      dontWrapQtApps = true;

      setupHook = self.writeText "python-qt-binding-setup-hook" ''
        _pythonQtBindingPreFixupHook() {
          # Prevent /build RPATH references
          rm -rf devel/lib
        }
        preFixupHooks+=(_pythonQtBindingPreFixupHook)
      '';

      postPatch = ''
        sed -e "1 i\\import PyQt5" \
            -e "s#sipconfig\._pkg_config\['default_mod_dir'\], 'PyQt5'#PyQt5.__path__[0]#" \
            -e "s#with open(os.path.join(tmpdirname, 'QtCore', 'QtCoremod.sip'), 'w') as outfp:##" \
            -e "s#outfp.write(output)##" \
            -i cmake/sip_configure.py
      '';
    });

    rqt-console = rosSuper.rqt-console.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_console/rqt_console"
      '';
    });

    rqt-graph = rosSuper.rqt-graph.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/bin/rqt_graph"
        wrapQtApp "$out/lib/rqt_graph/rqt_graph"
      '';
    });

    rqt-gui = rosSuper.rqt-gui.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/bin/rqt"
        wrapQtApp "$out/lib/rqt_gui/rqt_gui"
      '';
    });

    rqt-image-view = rosSuper.rqt-image-view.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_image_view/rqt_image_view"
      '';
    });

    rqt-msg = rosSuper.rqt-msg.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_msg/rqt_msg"
      '';
    });

    rqt-plot = rosSuper.rqt-plot.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_plot/rqt_plot"
      '';
    });
    
    rqt-publisher = rosSuper.rqt-publisher.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_publisher/rqt_publisher"
      '';
    });

    rqt-py-console = rosSuper.rqt-py-console.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_py_console/rqt_py_console"
      '';
    });

    rqt-reconfigure = rosSuper.rqt-reconfigure.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_reconfigure/rqt_reconfigure"
      '';
    });

    rqt-robot-monitor = rosSuper.rqt-robot-monitor.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_robot_monitor/rqt_robot_monitor"
      '';
    });

    rqt-service-caller = rosSuper.rqt-service-caller.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_service_caller/rqt_service_caller"
      '';
    });

    rqt-shell = rosSuper.rqt-shell.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_shell/rqt_shell"
      '';
    });

    rqt-srv = rosSuper.rqt-srv.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_srv/rqt_srv"
      '';
    });

    rqt-topic = rosSuper.rqt-topic.overrideAttrs ({
      nativeBuildInputs ? [], postFixup ? "", ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = postFixup + ''
        wrapQtApp "$out/lib/rqt_topic/rqt_topic"
      '';
    });

    rxcpp-vendor = patchVendorUrl rosSuper.rxcpp-vendor {
      url = "https://github.com/ReactiveX/RxCpp/archive/v4.1.0.tar.gz";
      sha256 = "1smxrcm0s6bz05185dx1i2xjgn47rq7m247pblil6p3bmk3lkfyk";
    };

    shared-queues-vendor = patchVendorUrl (patchVendorUrl rosSuper.shared-queues-vendor {
      url = "https://github.com/cameron314/concurrentqueue/archive/8f65a8734d77c3cc00d74c0532efca872931d3ce.zip";
      sha256 = "0cmsmgc87ndd9hiv187xkvjkn8fipn3hsijjc864h2lfcyigbxq1";
    }) {
      url = "https://github.com/cameron314/readerwriterqueue/archive/ef7dfbf553288064347d51b8ac335f1ca489032a.zip";
      sha256 = "1255n51y1bjry97n4w60mgz6b9h14flfrxb01ihjf6pwvvfns8ag";
    };

    swri-profiler-tools = rosSuper.swri-profiler-tools.overrideAttrs ({
      nativeBuildInputs ? [], ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = ''
        wrapQtApp "$out/lib/swri_profiler_tools/profiler"
      '';
    });

    tf = patchBoostSignals rosSuper.tf;

    tf2 = patchBoostSignals rosSuper.tf2;

    tinydir-vendor = patchVendorUrl rosSuper.tinydir-vendor {
      url = "https://github.com/cxong/tinydir/archive/1.2.4.tar.gz";
      sha256 = "1qjwky7v4b9d9dmxzsybnhiz6xgx94grc67sdyvlp1d4kfkfsl4w";
    };

    turtlesim = rosSuper.turtlesim.overrideAttrs ({
      nativeBuildInputs ? [], ...
    }: {
      dontWrapQtApps = false;
      nativeBuildInputs = nativeBuildInputs ++ [ self.qt5.wrapQtAppsHook ];
      postFixup = ''
        wrapQtApp "$out/lib/turtlesim/turtlesim_node"
      '';
    });

    uncrustify-vendor = patchVendorUrl rosSuper.uncrustify-vendor {
      url = "https://github.com/uncrustify/uncrustify/archive/uncrustify-0.68.1.tar.gz";
      sha256 = "04ndwhcn9iv3cy4p5wgh5z0vx2sywqlydyympn9m3h5458w1aijh";
    };

    urdf = patchBoostPython rosSuper.urdf;

    vrpn = rosSuper.vrpn.overrideAttrs { 
      src = self.fetchurl {
        url = "https://github.com/ros2-gbp/vrpn-release/archive/release/rolling/vrpn/7.35.0-20.tar.gz";# "https://github.com/alvinsunyixiao/vrpn/archive/9493113de3ace0a8dd1de1e3ff44a4db4cebcdb3.tar.gz";
        name = "7.35.0-20.tar.gz";
        sha256 = "831455c11c3016a4ef652ebd8c24ece8af87af59ef879e357a4847017b05e571"; # "e423e3215117a50bccbf2e7f65cfd117d34447fea193bc49ba0af7c442f5521d";#"0fa4eb542c2a0d4c34ea15bcfdf860835e3241d20a30885aa68231dea2d53fe7";
      };
    };
  };

  otherSplices = {
    selfBuildBuild = self.pkgsBuildBuild.rosPackages.${distro};
    selfBuildHost = self.pkgsBuildHost.rosPackages.${distro};
    selfBuildTarget = self.pkgsBuildTarget.rosPackages.${distro};
    selfHostHost = self.pkgsHostHost.rosPackages.${distro};
    selfTargetTarget = self.pkgsTargetTarget.rosPackages.${distro} or {};
  };

  keep = rosSelf: {
    inherit (rosSelf) lib buildRosPackage;
  };
in self.lib.makeScopeWithSplicing
  self.splicePackages
  self.newScope
  otherSplices
  keep
  (_: {})
  (rosSelf: self.lib.composeManyExtensions ([
    base
    (import (./. + "/${distro}/generated.nix"))
    overrides
  ]
  ++ self.lib.optional (version == 1) (import ./ros1-overlay.nix self)
  ++ self.lib.optional (version == 2) (import ./ros2-overlay.nix self)
  ++ [
    (import (./. + "/${distro}/overrides.nix") self)
  ]) rosSelf {})
