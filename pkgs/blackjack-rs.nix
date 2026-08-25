{
  lib,
  fetchCrate,
  rustPlatform,
}: let
  src = fetchCrate {
    pname = "blackjack-rs";
    version = "0.1.1";
    sha256 = "sha256-bINIvjVqn1CBLIzNY4UVodhO2P8CyvFvXY7VKBZQ4+c=";
  };
in
  rustPlatform.buildRustPackage {
    pname = "blackjack-rs";
    version = "0.1.0";

    inherit src;

    cargoHash = "sha256-bGXXqMEhsLgfX5lACOaaH24X36xKIUoYv1f698cJcbY=";
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
