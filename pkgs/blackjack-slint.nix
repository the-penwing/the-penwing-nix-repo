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
    rev = "eec68b7a1a8a306c0ca28b2d14d45d1e0496e31d";
    sha256 = "sha256-PajXxLY0tIXLtt0wo1AGtlaEnE4p+71g+nC4oawtgHM=";
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

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "blackjack-rs-0.1.0" = "sha256-SmJXz/GTtUBCs/ILFW+9qsp1i9lOKquL6na4eGwkenM=";
      };
    };

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
