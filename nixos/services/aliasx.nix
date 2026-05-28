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
        sha256 = "1kywdis5j7vv5pii22cvvqf3z3qbz8mbxy16awfq7kck2xfs8sds";
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
