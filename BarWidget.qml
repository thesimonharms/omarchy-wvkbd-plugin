import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui

BarWidget {
  id: root
  moduleName: "simon.wvkbd"

  // Landscape keyboard height in pixels; override in the shell.json layout
  // entry: { "id": "simon.wvkbd", "height": 500 }
  property int keyboardHeight: setting("height", 400)

  property bool keyboardUp: false

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function refresh() {
    if (statusProc.running) return
    statusProc.command = ["pgrep", "--count", "-x", "wvkbd-mobintl"]
    statusProc.running = true
  }

  function toggle() {
    if (!root.bar) return
    root.bar.run("sh -c 'pgrep -x wvkbd-mobintl >/dev/null && pkill -x wvkbd-mobintl || wvkbd-mobintl -L "
      + root.keyboardHeight + "'")
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
  // button: `omarchy-shell simon.wvkbd toggle`
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
