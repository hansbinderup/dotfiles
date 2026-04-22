{ pkgs, ... }:
let
  version = "0.2.1";
in
{
  environment.systemPackages = with pkgs; [
    (pkgs.stdenv.mkDerivation {
      pname = "aliasx";
      inherit version;

      src = pkgs.fetchurl {
        url = "https://github.com/hansbinderup/aliasx/releases/download/${version}/aliasx-${version}";
        # hash can be found on the releases page next to the asset
        sha256 = "496d1191074a478014be504802204c9bbb217e4867e8f04b8ef0fefaf3cd0817";
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
