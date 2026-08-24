{
  lib,
  stdenv,
  fetchgit,
  rustPlatform,
  pkg-config,
  makeWrapper,
  fontconfig,
  libxkbcommon,
  wayland,
  wayland-protocols,
  vulkan-loader,
  libGL,
  mesa,
  libx11,
  libxcursor,
  libxi,
  libxrandr,
  darwin,
}: let
  src = fetchgit {
    url = "https://github.com/the-penwing/blackjack-slint.git";
    rev = "86c7c688b2795edbdb8d9e9a3fd2fc4b09b1a9d2";
    sha256 = "sha256-xWeU2HMzreyvTDTdnOxNLzh0OVvEfqUwKduKXWmm1II=";
  };

  isDarwin = stdenv.hostPlatform.isDarwin;

  linuxRuntimeLibs = [
    libxkbcommon
    wayland
    vulkan-loader
    fontconfig
    libGL
    mesa
    libx11
    libxcursor
    libxi
    libxrandr
  ];

  linuxBuildInputs = [
    fontconfig
    libxkbcommon
    wayland
    wayland-protocols
    vulkan-loader
    libGL
    mesa
    libx11
    libxcursor
    libxi
    libxrandr
  ];

  darwinBuildInputs = with darwin.apple_sdk.frameworks; [
    AppKit
    QuartzCore
    Metal
    Foundation
  ];
in
  rustPlatform.buildRustPackage {
    pname = "blackjack-slint";
    version = "0.1.0";

    inherit src;

    cargoLock.lockFile = "${src}/Cargo.lock";

    nativeBuildInputs = [pkg-config makeWrapper];
    buildInputs =
      if isDarwin
      then darwinBuildInputs
      else linuxBuildInputs;

    postInstall = ''
      mkdir -p $out/share/blackjack-slint
      cp -r ${src}/assets $out/share/blackjack-slint/assets

      wrapProgram $out/bin/blackjack-slint \
        --set BLACKJACK_ASSETS_DIR $out/share/blackjack-slint/assets \
        ${lib.optionalString (!isDarwin)
        "--set LD_LIBRARY_PATH ${lib.makeLibraryPath linuxRuntimeLibs}"}
    '';

    meta = {
      description = "Blackjack GUI built with Slint";
      homepage = "https://github.com/the-penwing/blackjack-slint";
      platforms = lib.platforms.unix;
    };
  }
