import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "." as DV

// Vertical toolbar for drawing tools
Rectangle {
    id: root
    width: DV.Theme.sizes.toolBarWidth
    color: DV.Theme.colors.panelBackground
    
    // Signal emitted when a tool is selected
    signal toolSelected(string toolName)
    
    // Current active tool
    property string activeTool: ""
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: DV.Theme.sizes.toolBarPadding
        spacing: DV.Theme.sizes.toolBarSpacing
        
        // Selection tool button
        Button {
            id: selButton
            Layout.preferredWidth: DV.Theme.sizes.toolButtonSize
            Layout.preferredHeight: DV.Theme.sizes.toolButtonSize
            Layout.alignment: Qt.AlignHCenter
            
            text: ""
            checkable: true
            checked: root.activeTool === "select" || root.activeTool === ""
            
            contentItem: Item {
                anchors.fill: parent
                PhIcon {
                    anchors.centerIn: parent
                    name: "hand-pointing"
                    size: DV.Theme.sizes.iconSize
                    color: "white"
                }
            }
            
            onClicked: {
                if (checked) {
                    root.activeTool = "select"
                    rectButton.checked = false
                    root.toolSelected("select")
                } else {
                    root.activeTool = ""
                    root.toolSelected("")
                }
            }
            
            // Visual feedback for active state
            background: Rectangle {
                color: selButton.checked ? DV.Theme.colors.panelActive : (selButton.hovered ? DV.Theme.colors.panelHover : DV.Theme.colors.panelBackground)
                border.color: selButton.checked ? "#ffffff" : DV.Theme.colors.borderDefault
                border.width: 1
                radius: DV.Theme.sizes.radiusMd
            }
        }
        
        // Rectangle tool button
        Button {
            id: rectButton
            Layout.preferredWidth: DV.Theme.sizes.toolButtonSize
            Layout.preferredHeight: DV.Theme.sizes.toolButtonSize
            Layout.alignment: Qt.AlignHCenter
            
            text: ""
            checkable: true
            checked: root.activeTool === "rectangle"
            
            contentItem: Item {
                anchors.fill: parent
                PhIcon {
                    anchors.centerIn: parent
                    name: "rectangle"
                    size: DV.Theme.sizes.iconSize
                    color: "white"
                }
            }
            
            onClicked: {
                if (checked) {
                    root.activeTool = "rectangle"
                    selButton.checked = false
                    root.toolSelected("rectangle")
                } else {
                    root.activeTool = ""
                    root.toolSelected("")
                }
            }
            
            // Visual feedback for active state
            background: Rectangle {
                color: rectButton.checked ? DV.Theme.colors.panelActive : (rectButton.hovered ? DV.Theme.colors.panelHover : DV.Theme.colors.panelBackground)
                border.color: rectButton.checked ? "#ffffff" : DV.Theme.colors.borderDefault
                border.width: 1
                radius: DV.Theme.sizes.radiusMd
            }
        }
        
        // Spacer to push tools to the top
        Item {
            Layout.fillHeight: true
        }
    }
}

