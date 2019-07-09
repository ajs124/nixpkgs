{ stdenv, fetchurl, flex }:

stdenv.mkDerivation rec {
  pname = "drbd-utils";
  version = "9.10.0";

  src = fetchurl {
    url = "https://www.linbit.com/downloads/drbd/utils/${pname}-${version}.tar.gz";
    sha256 = "19phd1v73jk3ccmidj37gdh7gr3qwnpbn5n6351xkmbc1lcgyxnm";
  };

  postPatch = ''
    patchShebangs .
  '';

  configureFlags = [
    "--with-prebuiltman"
    "--prefix=/"
  ];

  makeFlags = [
    "DESTDIR=$$out"
  ];

  postInstall = ''
    cd $out
    while [[ $(find -type d -empty | wc -l) != 0 ]]
    do
      find -type d -empty -delete
    done
  '';

  nativeBuildInputs = [
    flex
  ];

  meta = with stdenv.lib; {
    homepage = http://www.drbd.org/;
    description = "Distributed Replicated Block Device, a distributed storage system for Linux";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
