{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, fzf
, go
, chafa
}:

buildGoModule rec {
  pname = "wallhaven-cli";
  version = "2.0.5";

  src = fetchFromGitHub {
    owner = "r3tr0ananas";
    repo = "wallhaven-cli";
    rev = "v${version}";
    sha256 = "0c29d9cm9l7b71455fwm0jlcpnwm77j3qybpxkxqc5vw7snf4vzp"; # Replace with actual hash
  };

  vendorHash = "sha256-Bz1u7u1Xk8UjIJqGJK0CGkFnT+baXP6LeskBgMpWJWo=";

  subPackages = [ "wallhaven" ];

  meta = with lib; {
    description = "Command line interface for wallhaven.cc";
    homepage = "https://github.com/r3tr0ananas/wallhaven-cli";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}