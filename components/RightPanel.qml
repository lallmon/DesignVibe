import QtQuick
import QtQuick.Controls
import "." as DV

// Right panel containing object properties and other inspectors
Pane {
    id: root
    padding: DV.Theme.sizes.rightPanelPadding
    
    contentItem: ObjectPropertiesInspector {
        anchors.fill: parent
        selectedItem: DV.SelectionManager.selectedItem
    }
}

