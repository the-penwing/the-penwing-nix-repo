{
  lib,
  fetchgit,
  rustPlatform,
}: let
  src = fetchgit {
    url = "https://github.com/the-penwing/blackjack-rs.git";
    rev = "8233d1e39e066df76680aea95eea8d84cafc3c14";
    sha256 = "sha256-zYsRzYM6wRskJcch4bORWCicHrsTAbowvZmJkHwuL1s=";
  };
in
  rustPlatform.buildRustPackage {
    pname = "blackjack-rs";
    version = "0.1.0";

    inherit src;

    cargoLock.lockFile = "${src}/Cargo.lock";

    meta = {
      description = "Blackjack for the terminal - Written in Rust";
      homepage = "https://github.com/the-penwing/blackjack-rs";
      license = lib.licenses.agpl3Only;
      maintainers = [
        {
          name = "Ben van Leeuwen";
          email = "benvanleeuwen01@gmail.com";
          github = "the-penwing";
        }
      ];
    };
  }
