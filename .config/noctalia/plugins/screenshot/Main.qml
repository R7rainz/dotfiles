import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Services.UI
import qs.Services.Noctalia
import qs.Services.Compositor

Item {
    property var pluginApi: null

    Process {
        id: screenshotProcess
        onExited: code => {
            if (code === 0) {
                ToastService.showNotice(pluginApi?.tr("notification.title"), pluginApi?.tr("notification.success"), "camera", 3000)
            }
        }
    }

    IpcHandler {
        target: "plugin:screenshot"

        function takeScreenshot(mode: string): bool {
            if (screenshotProcess.running) return false;
            
            var args = [];
            if (CompositorService.isHyprland) {
                args = [
                    "hyprshot",
                    "--freeze",
                    "--clipboard-only",
                    "--mode", mode,
                    "--silent"
                ]
            } else if (CompositorService.isNiri) {
                args = [
                    "niri", "msg", "action", "screenshot"
                ]
            } else if (CompositorService.isSway) {
                args = ["grimshot"]

                if (mode === "screen") {
                    args.push("copy", "output")
                } else if (mode === "region") {
                    args.push("copy", "area")
                } else {
                    args.push("copy", "area")
                }
            } else {
                // Fallback: notify user that screenshots are unsupported
                ToastService.showError(pluginApi?.tr("notification.title"), pluginApi?.tr("notification.unsupported-compositor"), 3000)
                return false
            }

            screenshotProcess.command = args
            screenshotProcess.running = true

            return true
        }
    }
}
