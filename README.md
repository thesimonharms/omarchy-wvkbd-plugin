# omarchy-wvkbd-plugin

An [Omarchy](https://omarchy.org/) shell plugin that adds a bar widget for
toggling [wvkbd](https://git.sr.ht/~proycon/wvkbd), a lightweight on-screen
keyboard for Wayland. Useful for laptops with detachable keyboards.

The keyboard is a custom wvkbd build (`wvkbd-pcintl`) with a traditional
PC-style layout:

```
Esc  F1  F2  F3  F4  F5  F6  F7  F8  F9  F10 F11 F12 Del
`    1   2   3   4   5   6   7   8   9   0   -   =   Bksp
Tab  q   w   e   r   t   y   u   i   o   p   [   ]   \
Caps a   s   d   f   g   h   j   k   l   ;   '   Enter
Shift    z   x   c   v   b   n   m   ,   .   /     Shift
Ctrl Super Alt         Space        AltGr ←  ↑  ↓  →
```

The widget shows a keyboard icon in the bar:

- **Click** to show/hide the on-screen keyboard
- The icon highlights while the keyboard is running

## Requirements

- Omarchy (or any Hyprland + Quickshell setup using the Omarchy shell)
- The custom `wvkbd-pcintl` binary. Build and install it (needs root for
  the install step, so it will prompt):

```bash
git clone https://github.com/thesimonharms/omarchy-wvkbd-plugin.git
cd omarchy-wvkbd-plugin/wvkbd-pcintl
./build.sh
```

## Install

```bash
omarchy plugin add https://github.com/thesimonharms/omarchy-wvkbd-plugin.git --enable --yes
```

This clones the plugin into `~/.config/omarchy/plugins/omarchy-wvkbd/`,
enables it, and adds it to your bar (right section by default). If the
widget doesn't appear immediately, restart the shell:

```bash
omarchy restart shell
```

### Configuration

Settings are overrides on the layout entry in `~/.config/omarchy/shell.json`:

```json
{
  "id": "omarchy-wvkbd",
  "height": 500
}
```

- `height` — landscape keyboard height in pixels (default `400`)
- `layers` — wvkbd layer(s), comma-separated (default `full`, the PC-style
  layout). The custom build only contains this one layer.
- `binary` — wvkbd variant to launch. Default is `wvkbd-pcintl` (the custom
  PC layout build). Set to `wvkbd-mobintl` for the stock AUR package with
  its phone-style layouts (`omarchy pkg aur add wvkbd` provides it).

## Uninstall

```bash
omarchy plugin remove omarchy-wvkbd --yes
```

This removes the plugin from `~/.config/omarchy/plugins/omarchy-wvkbd/`,
unloads it from the running shell, and drops it from your bar layout
(shell.json keeps an automatic backup of the removed copy).

## License

[MIT](LICENSE)
