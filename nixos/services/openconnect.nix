{ config, pkgs, ... }:

let
  openconnect-sso = pkgs.python3Packages.buildPythonApplication {
    pname = "openconnect-sso";
    version = "0-unstable-2024-04-22";
    format = "pyproject";

    src = pkgs.fetchFromGitHub {
      owner = "vlaci";
      repo = "openconnect-sso";
      rev = "94128073ef49acb3bad84a2ae19fdef926ab7bdf";
      sha256 = "08cqd40p9vld1liyl6qrsdrilzc709scyfghfzmmja3m1m7nym94";
    };

    postPatch = ''
      substituteInPlace pyproject.toml \
        --replace-fail 'requires = ["poetry>=0.12"]' 'requires = ["poetry-core>=1.0.0"]' \
        --replace-fail 'build-backend = "poetry.masonry.api"' 'build-backend = "poetry.core.masonry.api"'
    '';

    nativeBuildInputs = with pkgs.python3Packages; [
      poetry-core
      pythonRelaxDepsHook
    ];

    pythonRelaxDeps = [ "keyring" "lxml" "pyxdg" ];

    propagatedBuildInputs = with pkgs.python3Packages; [
      attrs
      colorama
      lxml
      keyring
      prompt-toolkit
      pyxdg
      requests
      structlog
      toml
      setuptools
      pysocks
      pyqt6
      pyqt6-webengine
      pyotp
    ];
  };
in
{
  environment.systemPackages = [
    openconnect-sso
    pkgs.openconnect
  ];
}
