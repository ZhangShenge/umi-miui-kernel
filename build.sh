#!/bin/bash
set -euo pipefail

# Xiaomi Mi 10 (umi) Kernel Build Script
# SukiSU Ultra v4.2.1 + SUSFS v2.3.0

DEFCONFIG="umi_sukisu_susfs_defconfig"
OUT="out"
JOBS="16"

export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=umi
export KBUILD_BUILD_HOST=github

echo "==> Applying config: "
make O="" LLVM=1 LLVM_IAS=1 ""

echo "==> Building Image and DTBs ( jobs)..."
make O="" LLVM=1 LLVM_IAS=1 -j"" Image dtbs

echo "==> Build finished successfully! Kernel Image: /arch/arm64/boot/Image"
