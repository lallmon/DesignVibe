import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

// Tool Settings Bar - displays settings for the currently active tool
ToolBar {
    id: root
    height: 48
    
    // Properties
    property string activeTool: ""  // Current tool ("select", "rectangle", etc.)
    
    // Tool-specific settings
    property real rectangleStrokeWidth: 1
    property color rectangleStrokeColor: "#ffffff"  // White by default
    property color rectangleFillColor: "#ffffff"  // White by default
    property real rectangleFillOpacity: 0.0  // Transparent by default (0-1)
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 8
        
        // Rectangle tool settings
        RowLayout {
            id: rectangleSettings
            visible: root.activeTool === "rectangle"
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 6
                
            Label {
                text: qsTr("Stroke Width:")
                font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter
            }
            
            TextField {
                id: strokeWidthInput
                Layout.preferredWidth: 50
                Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignVCenter
                text: root.rectangleStrokeWidth.toString()
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: 11
                validator: DoubleValidator {
                    bottom: 0.1
                    top: 100.0
                    decimals: 1
                }
                
                function commitValue() {
                    var value = parseFloat(text);
                    if (!isNaN(value) && value >= 0.1 && value <= 100.0) {
                        root.rectangleStrokeWidth = value;
                        console.log("Stroke width set to:", value);
                    } else {
                        // Reset to current value if invalid
                        text = root.rectangleStrokeWidth.toString();
                    }
                }
                
                onEditingFinished: {
                    commitValue();
                }
                
                onActiveFocusChanged: {
                    if (!activeFocus) {
                        commitValue();
                    }
                }
                
                background: Rectangle {
                    color: "#3a3a3a"
                    border.color: strokeWidthInput.activeFocus ? "#0078d4" : "#555555"
                    border.width: 1
                    radius: 2
                }
                
                color: "#ffffff"
            }
            
            Label {
                text: qsTr("px")
                font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter
            }
            
            // Separator
            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 6
                Layout.rightMargin: 6
                color: "#555555"
            }
            
            Label {
                text: qsTr("Stroke Color:")
                font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter
            }
            
            Button {
                id: strokeColorButton
                Layout.preferredWidth: 16
                Layout.preferredHeight: 16
                Layout.alignment: Qt.AlignVCenter
                
                onClicked: {
                    strokeColorDialog.open();
                }
                
                background: Rectangle {
                    color: root.rectangleStrokeColor
                    border.color: "#555555"
                    border.width: 1
                    radius: 2
                }
            }
            
            // Separator
            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 16
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 6
                Layout.rightMargin: 6
                color: "#555555"
            }
            
            Label {
                text: qsTr("Fill Color:")
                font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter
            }
            
            Button {
                id: fillColorButton
                Layout.preferredWidth: 16
                Layout.preferredHeight: 16
                Layout.alignment: Qt.AlignVCenter
                
                onClicked: {
                    fillColorDialog.open();
                }
                
                background: Rectangle {
                    border.color: "#555555"
                    border.width: 1
                    radius: 2
                    color: "transparent"
                    clip: true
                    
                    // Checkerboard pattern to show transparency
                    Canvas {
                        anchors.fill: parent
                        z: 0
                        onPaint: {
                            var ctx = getContext("2d");
                            ctx.clearRect(0, 0, width, height);
                            
                            // Draw checkerboard
                            var size = 4;
                            for (var y = 0; y < height; y += size) {
                                for (var x = 0; x < width; x += size) {
                                    if ((Math.floor(x/size) + Math.floor(y/size)) % 2 === 0) {
                                        ctx.fillStyle = "#999999";
                                    } else {
                                        ctx.fillStyle = "#666666";
                                    }
                                    ctx.fillRect(x, y, size, size);
                                }
                            }
                        }
                        Component.onCompleted: requestPaint()
                    }
                    
                    // Fill color with opacity applied
                    Rectangle {
                        anchors.fill: parent
                        z: 1
                        color: root.rectangleFillColor
                        opacity: root.rectangleFillOpacity
                    }
                }
            }
            
            Label {
                text: qsTr("Opacity:")
                font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter
            }
            
            Slider {
                id: opacitySlider
                Layout.preferredWidth: 80
                // When we customize handle/background, the Slider can lose its implicit height,
                // which causes RowLayout to give it ~0 height (no hit area). Explicitly size it.
                Layout.preferredHeight: 16
                implicitHeight: 16
                Layout.alignment: Qt.AlignVCenter
                from: 0
                to: 100
                stepSize: 1
                value: 0
                
                onPressedChanged: {
                    if (!pressed) {
                        // Update property when slider is released
                        root.rectangleFillOpacity = value / 100.0;
                    }
                }
                
                onValueChanged: {
                    // Update property as slider moves
                    root.rectangleFillOpacity = value / 100.0;
                }
                
                Component.onCompleted: {
                    value = Math.round(root.rectangleFillOpacity * 100);
                }
                
                Binding {
                    target: opacitySlider
                    property: "value"
                    value: Math.round(root.rectangleFillOpacity * 100)
                    when: !opacitySlider.pressed
                }
                
                background: Rectangle {
                    x: opacitySlider.leftPadding
                    y: opacitySlider.topPadding + opacitySlider.availableHeight / 2 - height / 2
                    width: opacitySlider.availableWidth
                    height: 4
                    // Provide implicit sizes so the control has a non-zero implicitHeight/Width in layouts
                    implicitWidth: 80
                    implicitHeight: 4
                    radius: 2
                    color: "#3a3a3a"
                    
                    Rectangle {
                        width: opacitySlider.visualPosition * parent.width
                        height: parent.height
                        color: "#0078d4"
                        radius: 2
                    }
                }
                
                handle: Rectangle {
                    x: opacitySlider.leftPadding + opacitySlider.visualPosition * (opacitySlider.availableWidth - width)
                    y: opacitySlider.topPadding + opacitySlider.availableHeight / 2 - height / 2
                    width: 12
                    height: 12
                    implicitWidth: 12
                    implicitHeight: 12
                    radius: 6
                    color: opacitySlider.pressed ? "#0078d4" : "#ffffff"
                    border.color: "#555555"
                    border.width: 1
                }
            }
            
            TextField {
                id: opacityInput
                Layout.preferredWidth: 35
                Layout.preferredHeight: 20
                Layout.alignment: Qt.AlignVCenter
                text: Math.round(root.rectangleFillOpacity * 100).toString()
                horizontalAlignment: TextInput.AlignHCenter
                font.pixelSize: 11
                validator: IntValidator {
                    bottom: 0
                    top: 100
                }
                
                function commitValue() {
                    var value = parseInt(text);
                    if (!isNaN(value) && value >= 0 && value <= 100) {
                        root.rectangleFillOpacity = value / 100.0;
                        console.log("Fill opacity set to:", root.rectangleFillOpacity);
                    } else {
                        // Reset to current value if invalid
                        text = Math.round(root.rectangleFillOpacity * 100).toString();
                    }
                }
                
                onEditingFinished: {
                    commitValue();
                }
                
                onActiveFocusChanged: {
                    if (!activeFocus) {
                        commitValue();
                    }
                }
                
                // Update text when property changes externally
                Connections {
                    target: root
                    function onRectangleFillOpacityChanged() {
                        if (!opacityInput.activeFocus) {
                            opacityInput.text = Math.round(root.rectangleFillOpacity * 100).toString();
                        }
                    }
                }
                
                background: Rectangle {
                    color: "#3a3a3a"
                    border.color: opacityInput.activeFocus ? "#0078d4" : "#555555"
                    border.width: 1
                    radius: 2
                }
                
                color: "#ffffff"
            }
            
            Label {
                text: qsTr("%")
                font.pixelSize: 11
                Layout.alignment: Qt.AlignVCenter
            }
        }
        
        // Stroke color picker dialog
        ColorDialog {
            id: strokeColorDialog
            title: qsTr("Choose Stroke Color")
            selectedColor: root.rectangleStrokeColor
            
            onAccepted: {
                root.rectangleStrokeColor = selectedColor;
                console.log("Stroke color set to:", selectedColor);
            }
        }
        
        // Fill color picker dialog
        ColorDialog {
            id: fillColorDialog
            title: qsTr("Choose Fill Color")
            selectedColor: root.rectangleFillColor
            
            onAccepted: {
                root.rectangleFillColor = selectedColor;
                console.log("Fill color set to:", selectedColor);
            }
        }
        
        // Select tool settings (empty for now)
        Item {
            visible: root.activeTool === "select" || root.activeTool === ""
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
        // Spacer
        Item {
            Layout.fillWidth: true
        }
    }
}

