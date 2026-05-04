{ pkgs, ... }:
let
  version = "0.2.2";
in
{
  environment.systemPackages = with pkgs; [
    (pkgs.stdenv.mkDerivation {
      pname = "aliasx";
      inherit version;

      src = pkgs.fetchurl {
        url = "https://github.com/hansbinderup/aliasx/releases/download/${version}/aliasx-${version}";
        # hash can be found on the releases page next to the asset
        sha256 = "ba69a45d1793cd831d5726f8be2afa0b8f3f1cde9b0911e32d7b1f59746cdccf";
      };

      nativeBuildInputs = [ pkgs.autoPatchelfHook ];
      buildInputs = [ pkgs.sqlite pkgs.gcc.cc.lib ];

      # No custom `phases` — let fixupPhase run so autoPatchelfHook can do its job
      dontUnpack = true;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        cp $src $out/bin/aliasx
        chmod +x $out/bin/aliasx
        runHook postInstall
      '';
    })
  ];
}
