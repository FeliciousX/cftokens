{ stdenv, fetchzip }:

stdenv.mkDerivation {
  pname = "commandbox";
  version = "5.9.1";
  src = fetchzip {
    url = "https://downloads.ortussolutions.com/ortussolutions/commandbox/5.9.1/commandbox-bin-5.9.1.zip";
    sha256 = "o/QMzEneKpUInbzUW1ioV0VyDLyjmwqyN9FnDhNYY2Q=";
  };

  meta.mainProgram = "box";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mv box $out/bin/box
    runHook postInstall
  '';
}