{
  lib,
  stdenv,
  fetchFromGitHub,
  cairo,
  glib,
  json_c,
  libepoxy,
  libpng,
  libxkbcommon,
  libGL,
  meson,
  ninja,
  pango,
  pkg-config,
  scdoc,
  wayland,
  wayland-protocols,
  wayland-scanner,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "greetd-mini-wl-greeter";
  version = "0-unstable-2021-11-04";

  src = fetchFromGitHub {
    owner = "philj56";
    repo = "greetd-mini-wl-greeter";
    rev = "c28c5249c4d3ba7076e2c6ea598e3ad93a168301";
    hash = "sha256-3q4FnjISe/MeF+egqpqHzDrBCNAkOjE6GxVmXMbqM9w=";
  };

  nativeBuildInputs = [
    libGL
    cairo
    glib
    json_c
    libepoxy
    libpng
    libxkbcommon
    pango
    wayland
    wayland-protocols
    wayland-scanner
  ];

  # https://github.com/philj56/greetd-mini-wl-greeter/issues/2
  mesonBuildType = "release";

  buildInputs = [
    meson
    ninja
    pkg-config
    scdoc
  ];

  meta = {
    description = "Extremely minimal raw Wayland greeter for greetd";
    homepage = "https://github.com/philj56/greetd-mini-wl-greeter";
    license = lib.licenses.mit;
  };
})
