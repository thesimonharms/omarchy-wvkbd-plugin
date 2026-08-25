import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy-wvkbd"

  // Settings are overrides on the shell.json layout entry:
  // { "id": "omarchy-wvkbd", "height": 500 }
  property int keyboardHeight: setting("height", 400)
  // wvkbd layer(s), comma-separated. "full" is the PC-style layout compiled
  // into wvkbd-pcintl (see wvkbd-pcintl/ in the plugin source).
  property string layers: setting("layers", "full")
  // The wvkbd variant to launch. Default is the custom PC-layout build;
  // set to "wvkbd-mobintl" to use the stock phone-style layout instead.
  property string binary: setting("binary", "wvkbd-pcintl")

  property bool keyboardUp: false

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function refresh() {
    statusProc.command = ["pgrep", "--count", "-x", root.binary]
    statusProc.running = true
  }

  function toggle() {
    if (!root.bar) return
    root.bar.run("sh -c 'pgrep -x " + root.binary + " >/dev/null && pkill -x " + root.binary
      + " || " + root.binary + " -L " + root.keyboardHeight + " -l " + root.layers
      + " --landscape-layers " + root.layers + "'")
    refreshTimer.interval = 200
    refreshTimer.restart()
  }

  Component.onCompleted: refresh()

  Timer {
    id: refreshTimer
    interval: 2000
    running: root.bar !== null
    repeat: true
    onTriggered: root.refresh()
  }

  Process {
    id: statusProc
    onExited: function(exitCode) {
      root.keyboardUp = exitCode === 0
    }
  }

  // IPC route so keybindings can toggle the keyboard in lockstep with the bar
  // button: `omarchy-shell wvkbd toggle`
  IpcHandler {
    target: "wvkbd"
    function toggle(): string {
      root.toggle()
      return "ok"
    }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰌌"
    active: root.keyboardUp
    tooltipText: root.keyboardUp ? "Hide virtual keyboard" : "Show virtual keyboard"
    onPressed: root.toggle()
  }
}
