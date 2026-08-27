{
  lib,
  fetchCrate,
  rustPlatform,
}: let
  src = fetchCrate {
    pname = "blackjack-rs";
    version = "0.2.0";
    sha256 = "sha256-zPLSuINkY/1JjlO9cluTlpRRNGv/z4jqMA9szcA5yeo=";
  };
in
  rustPlatform.buildRustPackage {
    pname = "blackjack-rs";
    version = "0.2.0";

    inherit src;

    cargoHash = "sha256-T8EYtqDqVKHzdV6tT1DLrU3282n9pp1L7dQ64ih3cH4=";
    doCheck = false;
    stripAllList = ["bin"];

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
