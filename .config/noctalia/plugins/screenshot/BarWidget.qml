import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Services.System
import qs.Services.Compositor
import qs.Widgets
import Quickshell.Io

NIconButton {
    id: root

    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    icon: "camera"
    tooltipText: pluginApi?.tr("tooltip")
    tooltipDirection: BarService.getTooltipDirection()
    baseSize: Style.capsuleHeight
    applyUiScale: false
    customRadius: Style.radiusL
    colorBg: Style.capsuleColor
    colorFg: Color.mOnSurface
    colorBorder: "transparent"
    colorBorderHover: "transparent"
    border.color: Style.capsuleBorderColor
    border.width: Style.capsuleBorderWidth

    readonly property string screenshotMode: 
        pluginApi?.pluginSettings?.mode || 
        pluginApi?.manifest?.metadata?.defaultSettings?.mode || 
        "region"

    Process {
        id: screenshotProcess
        onExited: code => {
            if (code === 0) {
                ToastService.showNotice(pluginApi?.tr("notification.title"), pluginApi?.tr("notification.success"), "camera", 3000);
            }
        }
    }

    function takeScreenshot(customArgs = null) {
        if (screenshotProcess.running) return;

        var args = [];
        if (customArgs) {
            args = customArgs;
        } else if (CompositorService.isHyprland) {
            args = ["hyprshot", "--freeze", "--clipboard-only", "--mode", screenshotMode, "--silent"];
        } else if (CompositorService.isNiri) {
            args = ["niri", "msg", "action", "screenshot"];
        } else if (CompositorService.isSway) {
            args = ["grimshot", "copy", "area"];

            if (screenshotMode === "screen" || screenshotMode === "fullscreen") {
                args = ["grimshot", "copy", "output"];
            } else if (screenshotMode === "window") {
                args = ["grimshot", "copy", "window"];
            }
        } else {
            // Fallback to hyprshot for other compositors
            args = ["hyprshot", "--freeze", "--clipboard-only", "--mode", screenshotMode, "--silent"];
        }

        screenshotProcess.command = args;
        screenshotProcess.running = true;
    }

    onClicked: {
        takeScreenshot();
    }

    onRightClicked: {
        PanelService.showContextMenu(contextMenu, root, screen);
    }

    NPopupContextMenu {
        id: contextMenu

        model: {
            var items = [
                {
                    "label": pluginApi?.tr("tooltip"),
                    "action": "take-screenshot",
                    "icon": "camera"
                }
            ];

            if (CompositorService.isHyprland) {
                items.push({
                    "label": pluginApi?.tr("actions.active-window"),
                    "action": "take-screenshot-active-window",
                    "icon": "window"
                });

                items.push({
                    "label": pluginApi?.tr("actions.active-screen"),
                    "action": "take-screenshot-active-screen",
                    "icon": "screen-share"
                });
            }

            items.push({
                "label": I18n.tr("actions.widget-settings"),
                "action": "widget-settings",
                "icon": "settings"
            });

            return items;
        }

        onTriggered: action => {
            contextMenu.close();
            PanelService.closeContextMenu(screen);

            if (action === "take-screenshot") {
                root.takeScreenshot();
            } else if (action === "take-screenshot-active-window") {
                root.takeScreenshot(["hyprshot", "-m", "window", "-m", "active", "--clipboard-only"]);
            } else if (action === "take-screenshot-active-screen") {
                root.takeScreenshot(["hyprshot", "-m", "output", "-m", "active", "--clipboard-only"]);
            } else if (action === "widget-settings") {
                BarService.openPluginSettings(screen, pluginApi.manifest);
            }
        }
    }
}
