# Xiaomi Mi 10 (umi) — Linux 4.19.325 with SukiSU Ultra & SUSFS

[![Device](https://img.shields.io/badge/Device-Xiaomi%20Mi%2010%20(umi)-blue.svg)](#)
[![SoC](https://img.shields.io/badge/SoC-Snapdragon%20865%20(SM8250)-orange.svg)](#)
[![Kernel](https://img.shields.io/badge/Kernel-4.19.325--cip135-green.svg)](#)
[![SukiSU](https://img.shields.io/badge/SukiSU%20Ultra-v4.2.1%20(40994--5)-purple.svg)](#)
[![SUSFS](https://img.shields.io/badge/SUSFS-v2.3.0%20(Inline%20Hook)-red.svg)](#)
[![Release](https://img.shields.io/badge/Release-BETA-yellow.svg)](#)

Custom Linux 4.19.325 CIP kernel source for **Xiaomi Mi 10** (`umi`), featuring built-in **SukiSU Ultra v4.2.1** driver with **UAPI 5** compatibility, **SUSFS v2.3.0 Inline Hook**, and **Zygisk Next** support.

---

## ⚠️ BETA Uyarısı ve Feragatname / Beta Disclaimer

> [!WARNING]
> **Bu çekirdek BETA aşamasındadır.**
>
> **Test Edilen Özellikler:**
> - Sistem açılışı ve normal çalışma
> - SukiSU Ultra Manager v4.2.1 tam entegrasyonu (UAPI 5)
> - Root izni verme ve modül yönetimi (Module Tab)
> - Zygisk Next 1.4.3+ algılama ve çalışma durumu
> - SUSFS v2.3.0 Inline Hook durumu
> - Şarj ve hızlı şarj
> - Kamera (MIUI Kamera / Leica)
> - Wi-Fi, Bluetooth, Ses, Ekran
>
> **Dikkat:** Günlük kullanım için uzun dönem kararlılık ve pil performansı henüz test aşamasındadır. Cihazınızda kalıcı değişiklik yapmadan önce daima stok `boot` ve `dtbo` bölümlerinizin yedeğini alınız. Oluşabilecek risklerden kullanıcı sorumludur.

---

## 🚀 Özellikler (Features)

- **Kernel Tabanı**: Linux 4.19.325 CIP (`cip135-st19`), SM8250 (Kona) platformu.
- **SukiSU Ultra Entegrasyonu**:
  - Dahili (built-in) sürücü olarak derlenmiştir (`drivers/kernelsu`).
  - UAPI sürümü `5` (`40994-5`) olarak yapılandırılmıştır; Manager arayüzü ile %100 uyumludur.
  - SukiSU Ultra Manager APK v2 sertifikası (`947ae944...`) çekirdek içine gömülüdür.
  - Seccomp bypass ve `susfs_zygote_sid` doğrulamaları uygulanmıştır.
- **SUSFS v2.3.0**:
  - `SUSFS_INLINE_HOOK` modu devrededir (kprobes yerine inline hook ile tam gizlilik).
  - `SUS_PATH`, `SUS_MOUNT`, `SUS_KSTAT`, `SPOOF_UNAME`, `HIDE_KSU_SUSFS_SYMBOLS`, `OPEN_REDIRECT` aktif.
- **Zygisk Next Desteği**: Zygisk Next 1.4.3+ ile tam uyumlu.
- **MIUI / HyperOS & AOSP Desteği**: OS1.0.7.0.TJBCNXM (Android 13) ve uyumlu ROM'lar.
- **Gömülü Yapılandırma**: `CONFIG_IKCONFIG` ve `CONFIG_IKCONFIG_PROC` etkin; çekirdek içi `.config` çıkarılabilir.

---

## 📦 Kurulum (Installation)

Hazır derlenmiş dosyaları [Releases](../../releases) sekmesinden indirebilirsiniz.

### Yöntem 1: TWRP / OrangeFox Recovery (Önerilen)
1. `umi-4.19.325-SukiSU-v4.2.1-SUSFS2.3.0-r3-AnyKernel3.zip` dosyasını telefon hafızasına kopyalayın.
2. Recovery moduna geçin ve ZIP dosyasını flaşlayın.
   *(AnyKernel3 hem `boot` hem de `dtbo` bölümlerini otomatik olarak günceller).*
3. Cihazı yeniden başlatın.

### Yöntem 2: Geçici Test (Fastboot Boot - Güvenli)
Kalıcı yazma yapmadan önce çalıştığından emin olmak için:
```bash
adb reboot bootloader
fastboot boot umi-4.19.325-SukiSU-v4.2.1-SUSFS2.3.0-r3-boot.img
```

### Yöntem 3: Fastboot ile Kalıcı Flaşlama
```bash
adb reboot bootloader
fastboot flash boot umi-4.19.325-SukiSU-v4.2.1-SUSFS2.3.0-r3-boot.img
fastboot flash dtbo dtbo.img
fastboot reboot
```

---

## 🛠️ Kaynak Koddan Derleme (Building from Source)

### Gereksinimler
- Linux / WSL (Ubuntu 20.04 / 22.04 / 24.04)
- **Toolchain**: Proton Clang 13.0+ veya AOSP Clang
- Gerekli paketler: `build-essential`, `libssl-dev`, `bison`, `flex`, `libncurses5-dev`, `bc`

### Derleme Adımları
```bash
# Repoyu klonlayın
git clone https://github.com/omertrans678/xiaomi-umi-sukisu-susfs.git
cd xiaomi-umi-sukisu-susfs

# Toolchain yolunu ayarlayın
export PATH="/path/to/proton-clang/bin:$PATH"

# Otomatik betik ile derleyin
./build.sh

# Veya manuel olarak:
make O=out ARCH=arm64 LLVM=1 LLVM_IAS=1 umi_sukisu_susfs_defconfig
make O=out ARCH=arm64 LLVM=1 LLVM_IAS=1 -j$(nproc) Image dtbs
```
Derlenen çekirdek imajı `out/arch/arm64/boot/Image` konumunda oluşacaktır.

---

## 🔒 Güvenlik ve Sertifika Bilgisi

SukiSU Ultra Manager APK'sı çekirdek içine gömülen resmi imza ile doğrulanır:
- **APK Sertifika SHA256**: `947ae944f3de4ed4c21a7e4f7953ecf351bfa2b36239da37a34111ad29993eef`
- **Sertifika Boyutu**: `860` bayt (`0x35c`)

---

## 🙏 Teşekkürler ve Krediler (Credits)

- [Linux Kernel Organization](https://kernel.org/) & [CIP Project](https://wiki.linuxfoundation.org/civilinfrastructureplatform/start)
- [Xiaomi](https://github.com/MiCode/Xiaomi_Kernel_OpenSource) & [Qualcomm](https://source.codeaurora.org/)
- [AstideLabs](https://github.com/AstideLabs/android_kernel_xiaomi_sm8250) (SM8250 kernel base & SUSFS port)
- [SukiSU Ultra Team](https://github.com/SukiSU-Ultra/SukiSU-Ultra)
- [KernelSU](https://github.com/tiann/KernelSU) by tiann
- [SUSFS](https://gitlab.com/simonpunk/susfs4ksu) by simonpunk
- [AnyKernel3](https://github.com/osm0sis/AnyKernel3) by osm0sis
