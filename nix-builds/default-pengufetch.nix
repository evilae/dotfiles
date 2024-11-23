{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
, go
}:

buildGoModule rec {
  pname = "pengufetch";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "r3tr0ananas";
    repo = "pengufetch";
    rev = "v${version}";
    sha256 = "sha256-bJDqp6KoybcKzXJLK8DTW9EvAII4XJr5LXki+ZDqLAo=";
  };

  vendorHash = "sha256-v5c9qdKa+DIHIRBG/hB5KhRMQdJoDV0c3DuMTFBdW3A=";

  meta = with lib; {
    description = "The codec you need!!";
    homepage = "https://github.com/r3tr0ananas/pengufetch";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}