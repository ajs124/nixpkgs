{ lib, fetchFromGitLab, buildGoModule, ruby, libkrb5 }:

buildGoModule rec {
  pname = "gitlab-shell";
  version = "14.35.0";

  # nixpkgs-update: no auto update
  src = fetchFromGitLab {
    owner = "gitlab-org";
    repo = "gitlab-shell";
    rev = "v${version}";
    sha256 = "sha256-WyIUdDKPKQE1Ddz40WaMA5lDs37OyDuZl/6/nKDYY/8=";
  };

  buildInputs = [ ruby libkrb5 ];

  patches = [
    ./remove-hardcoded-locations.patch

    # This patch was created by doing `nix run nixpkgs#go -- mod tidy`
    # TODO: Remove it again, once a future release updated the go.mod.
    ./go-1_21.patch
  ];

  vendorHash = "sha256-7TUHD14/aCs3lkpTy5CH9WYUc1Ud6rDFCx+JgsINvxU=";

  postInstall = ''
    cp -r "$NIX_BUILD_TOP/source"/bin/* $out/bin
    cp -r "$NIX_BUILD_TOP/source"/{support,VERSION} $out/
  '';
  doCheck = false;

  meta = with lib; {
    description = "SSH access and repository management app for GitLab";
    homepage = "http://www.gitlab.com/";
    platforms = platforms.linux;
    maintainers = teams.gitlab.members;
    license = licenses.mit;
  };
}
