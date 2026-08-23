{
  lib,
  fetchgit,
  rustPlatform,
}: let
  src = fetchgit {
    url = "https://github.com/the-penwing/blackjack-rs.git";
    rev = "e075cfa8f9ee924da021feba238a68f10847c55e";
    sha256 = "sha256-SmJXz/GTtUBCs/ILFW+9qsp1i9lOKquL6na4eGwkenM=";
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
