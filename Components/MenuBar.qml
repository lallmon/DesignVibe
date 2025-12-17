import QtQuick
import QtQuick.Controls

// Main menu bar component
MenuBar {
    id: root
    
    // Property to reference the canvas for zoom operations
    property var canvas: null
    
    Menu {
        title: qsTr("&File")
        Action {
            text: qsTr("E&xit (Ctrl+Q)")
            shortcut: StandardKey.Quit
            onTriggered: Qt.quit()
        }
    }
    
    Menu {
        title: qsTr("&View")
        Action {
            text: qsTr("Zoom &In (Ctrl++)")
            shortcut: StandardKey.ZoomIn
            onTriggered: {
                if (root.canvas) {
                    root.canvas.zoomIn()
                }
            }
        }
        Action {
            text: qsTr("Zoom &Out (Ctrl+-)")
            shortcut: StandardKey.ZoomOut
            onTriggered: {
                if (root.canvas) {
                    root.canvas.zoomOut()
                }
            }
        }
        Action {
            text: qsTr("&Reset Zoom (Ctrl+0)")
            shortcut: "Ctrl+0"
            onTriggered: {
                if (root.canvas) {
                    root.canvas.resetZoom()
                }
            }
        }
    }
}

