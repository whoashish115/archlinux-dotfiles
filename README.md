# Archlinux Dotfiles

My archlinux dot files :)

Based on the **Illogical Impulse** dotfiles by **end-4**, with my own modifications and additions.
- **Upstream:** https://github.com/end-4/dots-hyprland
- **Project Wiki:** https://ii.clsty.link/

Includes configurations for:

* Neovim
* Fish
* Kitty
* Obsidian
* Git
* Terminal
* Linux utilities
* Development tools
* Packages

Designed to keep my setup reproducible across machines.

## Screenshots

![](screenshots/4.png)

![](screenshots/5.png)


## Packages

![](packages.webp)

## Installation

Clone the repository:

```bash
git clone https://github.com/whoashish115/archlinux-dotfiles.git
cd archlinux-dotfiles
```

Copy or symlink the files you want to use.

Example:

```bash
ln -sf ~/archlinux-dotfiles/.zshrc ~/.zshrc
ln -sf ~/archlinux-dotfiles/.gitconfig ~/.gitconfig
```

Or manually copy only the configurations you need.


## Notes

These are my personal configuration files.

If you plan to use them:

- Review every configuration first.
- Remove anything you don't need.
- Replace any machine-specific paths.
- Never commit your own secrets or private keys.

Use at your own risk.

## License

This repository is licensed under the MIT License.

See the `LICENSE` file for details.
