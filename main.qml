import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "components"

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

    // Main layout with tool settings and content
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        // Tool Settings Bar
        ToolSettings {
            id: toolSettings
            Layout.fillWidth: true
            Layout.preferredHeight: 32
            activeTool: canvas.drawingMode === "" ? "select" : canvas.drawingMode
        }
        
        // Main content area with toolbar and canvas
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
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
                rectangleStrokeWidth: toolSettings.rectangleStrokeWidth
                rectangleStrokeColor: toolSettings.rectangleStrokeColor
                rectangleFillColor: toolSettings.rectangleFillColor
                rectangleFillOpacity: toolSettings.rectangleFillOpacity
            }
        }
    }
}
