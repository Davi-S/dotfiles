## Davi-S's Dotfiles – Arch Linux System State with aconfmgr

Welcome! This repository contains my personal system configuration for Arch Linux, which is managed entirely using [`aconfmgr`](https://github.com/CyberShadow/aconfmgr). It's designed so that I (or you!) can easily restore, review, or evolve my setup even after a long break.

### What is This?

- Purpose: Track all essential machine customizations (dotfiles, system tweaks, key applications, services, and more) in a reproducible, versioned way.
- Why use `aconfmgr`? It automates system state, making it easy to:
  - Reinstall or migrate my

### How My Setup is Organized

- Top-level numbered `.sh` files:
  These are aconfmgr configuration scripts. Each file targets a specific category or setup phase.
  Example:
    - `10-ignore.sh`: What to skip or ignore in tracking.
    - `20-base.sh`: Core system packages and settings.
    - `25-fonts.sh`, `35-coding.sh`, etc.: Fonts, coding tools, and so on.
- `files/` directory:
  Mirrors your system root (`/`).
  - Any file here represents a real file on my system that was changed after installation (unless explicitly ignored).
  - Most files here are things I hand-edited or care about tracking.

### How to Use or Restore This Setup

1. Install `aconfmgr`
   See [aconfmgr docs](https://github.com/CyberShadow/aconfmgr) for full instructions.

2. Clone this repo:

   ```bash
   git clone https://github.com/Davi-S/dotfiles ~/.config/aconfmgr
   cd ~/.config/aconfmgr
   ```

3. Review what would change:
   See what this config would do, before applying it:

   ```bash
   aconfmgr diff
   ```

4. Apply the configuration:
   This brings your system in line with the repo state:

   ```bash
   aconfmgr apply
   ```

   Warning: This will overwrite tracked files and install/remove packages as configured!

### Philosophy & Best Practices

- Minimal, tracked, reproducible:
  Only files I've truly customized (not auto-generated junk) are tracked.
- Separation of concerns:
  Scripts are organized by category and run order.

### Contributing or Adapting

- Suggestions/PRs welcome!
  This repo is a living document of my system.
- If you're adapting for yourself, change the scripts and tracked files to match your needs.

### License

MIT – See [LICENSE](LICENSE).
