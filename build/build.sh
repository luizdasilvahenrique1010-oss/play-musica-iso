#!/bin/bash
# Roda DENTRO do container debian:bookworm (chamado pelo workflow do GitHub).
set -euxo pipefail
REPO=/work
cd "$REPO/build"
rm -rf work && mkdir work && cd work

lb config noauto \
  --distribution bookworm \
  --architectures amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --debian-installer none \
  --binary-images iso-hybrid \
  --bootloaders "syslinux,grub-efi" \
  --memtest none \
  --apt-recommends false \
  --apt-indices false \
  --security true --updates true \
  --chroot-squashfs-compression-type gzip \
  --iso-application "Play Musica" \
  --iso-volume "PLAY_MUSICA" \
  --iso-publisher "Play Musica Jukebox" \
  --bootappend-live "boot=live components quiet splash locales=pt_BR.UTF-8 keyboard-layouts=br timezone=America/Maceio username=jukebox hostname=playmusica"

# configuracoes proprias (pacotes, hooks, arquivos do sistema)
cp -a "$REPO/build/overlay/." config/

# o jukebox em si (sem arquivos de Windows)
mkdir -p config/includes.chroot/opt/jukebox
cp -a "$REPO/jukebox/." config/includes.chroot/opt/jukebox/
rm -f config/includes.chroot/opt/jukebox/{INICIAR.bat,atualizar.ps1,LEIA-ME.txt}
find config/includes.chroot/opt/jukebox -name .gitkeep -delete

lb build

mkdir -p "$REPO/out"
ISO=$(ls -1 *.iso | head -n1)
cp "$ISO" "$REPO/out/PlayMusica.iso"
( cd "$REPO/out" && sha256sum PlayMusica.iso > PlayMusica.iso.sha256 )
ls -lh "$REPO/out"
