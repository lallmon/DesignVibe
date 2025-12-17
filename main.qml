import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Components"

ApplicationWindow {
    id: root
    width: 1920
    height: 1080
    visible: true
    title: qsTr("DesignVibe")

    // Menu Bar
    menuBar: MenuBar {
        canvas: canvas
    }

    // Status Bar
    footer: StatusBar {
        zoomLevel: canvas.zoomLevel
        cursorX: canvas.cursorX
        cursorY: canvas.cursorY
    }

    // Main content area with toolbar and canvas
    RowLayout {
        anchors.fill: parent
        spacing: 0
        
        // Left toolbar
        ToolBar {
            id: toolBar
            Layout.fillHeight: true
            
            onToolSelected: (toolName) => {
                canvas.setDrawingMode(toolName)
            }
        }
        
        // Main Canvas Area
        Canvas {
            id: canvas
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
