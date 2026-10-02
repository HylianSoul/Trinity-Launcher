# AGENTS.md

Qt6 / C++17 frontend for Minecraft Bedrock on Linux. No tests, no lint, no typecheck — verification is `build.sh --release`.

## Build

Use the wrapper, never raw `cmake`/`sudo`:
- `make start` — deps + release build + run (first clone)
- `make run` — rebuild + run local binary (dev loop)
- `make build` / `make debug` / `make clean` / `make deps`
- `make translations` — rescan `tr()` strings into `resources/i18n/*.ts`
- Binary lands at `build/app/trinity`. `build.sh` forces `clang++ -msse3` + Ninja if present.
- Never run `build.sh`/`cmake` as root — it breaks `build/` ownership (script self-repairs via `chown`, prefer `make clean` instead).
- CI (`compilar.yml`) is just `./build.sh --deps` then `./build.sh --release`.

## Layout

- `app/src/main.cpp` → `trinity` binary (links `TrinityCore` + `TrinityUI`).
- `src/TrinityLib/core/` + `include/TrinityLib/core/` → `TrinityCore` static lib (version_manager, game_launcher, pack_installer, exporter, discord_manager, color_extractor).
- `src/TrinityLib/ui/` + `include/TrinityLib/ui/` → `TrinityUI` static lib (windows/, dialogs/, widgets/).
- `src/mini-matugen-j/` → standalone `test_color_extractor` helper, not shipped.
- `resources/` — `resources.qrc` (fonts, branding), `i18n/*.ts` → compiled `.qm` embedded via `qt_add_resources` in root `CMakeLists.txt`.

## Gotchas

- Frontend only: launching the game needs external `mcpelauncher-client` + `mcpelauncher-extract` on PATH (see `docs/BUILD.md` §1, `qt6` branch). Don't add game-engine code here.
- Game data lives in `~/.local/share/mcpelauncher/` — uninstall keeps it; never delete it in scripts.
- i18n: Spanish (`trinity_es.ts`) is the source language; keep `%1`/`%2` placeholders and `&` shortcuts untranslated. New language = copy `trinity_es.ts`, register in root `CMakeLists.txt` (`TS_FILES`/`QM_FILES`) + `resources.qrc`, then `make translations`.
- `SHOW_X86_64_WARNING` is auto-defined on x86_64 (`src/TrinityLib/ui/CMakeLists.txt`); disable with `-DDISABLE_X86_64_WARNING=ON`, don't delete the guard.
- Nix (`flake.nix`) and `compose.yaml`/`Dockerfile` are for isolated builds only; default path is `make`.
- AppImages: only via `trinity-appimage.sh` on Arch (`CHANNEL=latest|nightly sh ./trinity-appimage.sh`; CI `anylinux-latest.yml`/`anylinux-nightly.yml` build both). Never hand-copy `.so` into the AppDir — pass binaries via `BINS` and let quick-sharun deploy (`STRACE_MODE=1`, hooks in `ADD_HOOKS` are load-bearing, don't drop them). `ANYLINUX_LIB=0` is mandatory: anylinux.so LD_PRELOAD interposition (execv/dlopen hooks) breaks webview spawn (login), Xbox presence (multiplayer) and SDL audio — verified 2026-10-01 (classic image works without it).
- AppImage releases: `anylinux-latest.yml` ("AnyLinux Latest" → tag `latest`, manual) + `anylinux-nightly.yml` ("AnyLinux Nightly" → tag `nightly`, daily cron). Both build the matrix x86_64+aarch64 and publish `Trinity_Launcher-$ARCH.AppImage`. `classic-universal-latest.yml` is the same pipeline for the catalog tags `latest-classic`/`nightly-classic`. Don't merge the pipelines; one tag = one writer via `concurrency`.
- Per `CONTRIBUTING.md`: Conventional Commits (`feat:`, `fix:`, …), `camelCase` funcs/vars, `PascalCase` classes, `UPPER_SNAKE` consts, `snake_case` files. Report-but-don't-fix running bugs, no unprompted refactors/optimizations.
