# omarchy-wvkbd-plugin

An [Omarchy](https://omarchy.org/) shell plugin that adds a bar widget for
toggling [wvkbd](https://git.sr.ht/~proycon/wvkbd), a lightweight on-screen
keyboard for Wayland. Useful for laptops with detachable keyboards.

The widget shows a keyboard icon in the bar:

- **Click** to show/hide the on-screen keyboard
- The icon highlights while the keyboard is running
- The toggle is also available over IPC, so keybindings stay in sync with
  the icon: `omarchy-shell wvkbd toggle`

## Requirements

- Omarchy (or any Hyprland + Quickshell setup using the Omarchy shell)
- `wvkbd` from the AUR:

```bash
omarchy pkg aur add wvkbd
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
  "height": 500,
  "layers": "fullwide"
}
```

- `height` — landscape keyboard height in pixels (default `400`)
- `layers` — wvkbd layer(s), comma-separated (default `full`, a traditional
  PC-style QWERTY with number row and modifiers). Run
  `wvkbd-mobintl --list-layers` for all options, e.g. `fullwide` for
  extra-wide keys, or `special,emoji` for the compact phone-style layout.

## Uninstall

```bash
omarchy plugin remove omarchy-wvkbd --yes
```

This removes the plugin from `~/.config/omarchy/plugins/omarchy-wvkbd/`,
unloads it from the running shell, and drops it from your bar layout
(shell.json keeps an automatic backup of the removed copy).

## License

[MIT](LICENSE)
