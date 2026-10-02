# Trinity Launcher 
### (This project is currently being maintained by a single developer. If you want to help, click the heart icon button and make a donation.)
### Important note: On x86_64, the maximum supported version of bedrock is 26.52.3
If you have an ARM-based device, you won't have any problems with the new versions.

[Official Website](https://trinity-la.github.io/)

[Official  Reddit](https://www.reddit.com/r/TrinityUnix/comments/1s3p2ot/errores_comunes_de_trinity_launcher/)

[![Version](https://img.shields.io/badge/version-9.0.9-blue)]()
[![Platform](https://img.shields.io/badge/platform-Linux-lightgrey)]()
[![License](https://img.shields.io/badge/license-BSD--3--Clause-green)]()

**Trinity Launcher** is a modular graphical environment designed to manage and run Minecraft: Bedrock Edition natively on Linux environments.
<img width="1024" height="740" alt="image psd" src="https://github.com/user-attachments/assets/b505c732-1d44-426d-a538-4c05d82cee18" />


---

### Key Features
* **Multi-version Management:** Extracts and organizes different versions of the game (APKs).
* **Content Manager (Trinito):** Centralized interface for Mods, Textures, Shaders, and Worlds.
* **Native Integration:** Support for Flatpak and native execution.
* **Discord Integration:** Rich Presence implemented natively.

---

### How does it work?
**Trinity Launcher** is a *frontend* designed to improve the management and usability of **Minecraft: Bedrock Edition** on Linux systems.

> **Special Acknowledgments:** Trinity is built upon the technical foundation of the [mcpelauncher-manifest](https://github.com/minecraft-linux) project.

---

## Installation

### AppImage (Linux)

Download from the [`latest`](https://github.com/Trinity-LA/Trinity-Launcher/releases/tag/latest)
release for the stable build, or [`nightly`](https://github.com/Trinity-LA/Trinity-Launcher/releases/tag/nightly)
for the daily one, which is rebuilt from the current code:

| File | Architecture |
| --- | --- |
| `Trinity_Launcher-x86_64.AppImage` | x86_64 |
| `Trinity_Launcher-aarch64.AppImage` | ARM64 |

Make it executable and run it:

```bash
chmod +x Trinity_Launcher-x86_64.AppImage
./Trinity_Launcher-x86_64.AppImage
```

Each AppImage ships its own C library and loader, so the same file works on
glibc systems, on musl-based ones (Alpine, Void) and on NixOS, with no extra
dependencies. Both files come with a `.zsync` next to them for resumable
downloads.

Trinity Launcher is also on [AppImageHub](https://appimage.github.io/), the
community directory of AppImages.

### Flatpak and DMG method:
Read [steps for install on linux and mac](https://github.com/Trinity-LA/Trinity-Launcher/releases/tag/2.6-beta)

### FOR NIXOS USERS 
Read [STEPS FOR RUN ON NIXOS OR USING NIX](https://codeberg.org/javiercplus/Trinity-Launcher-NIXOS/src/branch/main/)
### Method from source code
If you wish to compile the latest version from the repository:

1. **Clone the project:**
   ```bash
   git clone https://github.com/Trinity-LA/Trinity-Launcher.git
   cd Trinity-Launcher
   ```
2. **Install dependencies and compile:**
   ```bash
   chmod +x build.sh && ./build.sh --deps 
   ```

*(For a detailed guide, refer to [docs/BUILD.md](docs/BUILD.md))*

if you wanna use nix run only for test compile:
``` 
nix --extra-experimental-features "nix-command flakes" develop
```

---

## Technical Architecture

The project is divided into two main libraries:
- **`TrinityCore`**: File management logic, configuration, and communication with the Bedrock runtime.
- **`TrinityUI`**: User interface based on Qt6.

---

## Contributions
Contributions are welcome! Please read our [Contribution Guide](CONTRIBUTING.md) before opening a *Pull Request*.

---
