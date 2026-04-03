import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
    id: root

    property var pluginApi: null

    property string editMode: 
        pluginApi?.pluginSettings?.mode || 
        pluginApi?.manifest?.metadata?.defaultSettings?.mode || 
        "region"

    spacing: Style.marginM

    NComboBox {
        label: pluginApi?.tr("settings.mode.label") || "Screenshot Mode"
        description: pluginApi?.tr("settings.mode.description") || "Choose between region selection or direct screen capture"
        model: [
            {
                "key": "region",
                "name": pluginApi?.tr("settings.mode.region") || "Region Selection"
            },
            {
                "key": "screen",
                "name": pluginApi?.tr("settings.mode.screen") || "Full Screen"
            }
        ]
        currentKey: root.editMode
        onSelected: key => root.editMode = key
        defaultValue: pluginApi?.manifest?.metadata?.defaultSettings?.mode || "region"
    }

    function saveSettings() {
        if (!pluginApi) return;

        pluginApi.pluginSettings.mode = root.editMode;
        pluginApi.saveSettings();
    }
}
