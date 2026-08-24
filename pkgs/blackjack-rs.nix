{
  lib,
  fetchCrate,
  rustPlatform,
}: let
  src = fetchCrate {
    pname = "blackjack-rs";
    version = "0.1.0";
    sha256 = "sha256-+K9l1QMMHIg/HVAOdfzfgxAoEDdATW7eYKJsu8fPzxQ=";
  };
in
  rustPlatform.buildRustPackage {
    pname = "blackjack-rs";
    version = "0.1.0";

    inherit src;

    cargoHash = "sha256-VOnUiswMJW+lGvUNpngFHcDXO3xQs+DH5ECEijhEz48=";

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
