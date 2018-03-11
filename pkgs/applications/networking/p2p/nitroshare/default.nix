{ stdenv, fetchFromGitHub, pkgconfig, cmake, openssl, qtbase, qttools, qtsvg }:

stdenv.mkDerivation rec {
  name = "nitroshare-${version}";
  version = "0.3.4";

  src = fetchFromGitHub {
    owner = "nitroshare";
    repo = "nitroshare-desktop";
    rev = version;
    sha256 = "0yyb9v1kws3b700lnx8jwzlpf0w6jyra647v79j4h4737q9zw11z";
  };

  nativeBuildInputs = [ pkgconfig cmake ];
  buildInputs = [ qtbase qttools qtsvg openssl ];

  meta = with stdenv.lib; {
    description = "Cross-platform Network File Transfer Application";
    license = licenses.mit;
    homepage = https://nitroshare.net;
    platforms = platforms.all;
  };
}
