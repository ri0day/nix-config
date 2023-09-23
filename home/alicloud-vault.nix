{pkgs, ...}:
pkgs.stdenvNoCC.mkDerivation rec {
  name = "alicloud-vault";
  src = pkgs.fetchurl {
    url = "https://github.com/arafato/alicloud-vault/releases/download/v1.3.4/alicloud-vault-darwin-amd64";
    sha256 = "12251kl57ahg00ypi8ilax0i2ank1bidgrsf6d55dgvgax9j6mxv";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/alicloud-vault
    chmod +x $out/bin/alicloud-vault
  '';
}
