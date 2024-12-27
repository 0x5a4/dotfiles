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
  version = "0-unstable-2024-12-27";

  src = fetchFromGitHub {
    owner = "philj56";
    repo = "greetd-mini-wl-greeter";
    rev = "61f25ed34a1a35a061c2f3605fc3d4b37a7d0d8e";
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
    mainProgram = "greetd-mini-wl-greeter";
  };
})
