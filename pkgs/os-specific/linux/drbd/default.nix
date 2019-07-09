{ stdenv, fetchurl, kernel }:

let
  kernelBuildDir = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
  modDestDir = "$$out/lib/modules/${kernel.modDirVersion}/extra/drdb";
in stdenv.mkDerivation rec {
  pname = "drbd";
  version = "9.0.19-1";

  src = fetchurl {
    url = "https://www.linbit.com/downloads/drbd/9.0/${pname}-${version}.tar.gz";
    sha256 = "0n7shkpiab0d44757k21kx75416ghfkxw0zr1bj40aalk75jngav";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KVER=${kernel.version}"
    "KDIR=${kernelBuildDir}"
    "DESTDIR=${modDestDir}"
  ];

  meta = with stdenv.lib; {
    homepage = http://www.drbd.org/;
    description = "Distributed Replicated Block Device, a distributed storage system for Linux";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
