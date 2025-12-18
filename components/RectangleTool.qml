import QtQuick
import QtQuick.Controls

// Rectangle drawing tool component
Item {
    id: tool
    
    // Properties passed from Canvas
    property real zoomLevel: 1.0
    property bool active: false
    
    // Internal state
    property bool isDrawing: false
    property real drawStartX: 0
    property real drawStartY: 0
    property var currentRect: null
    
    // Signal emitted when a rectangle is completed
    signal rectangleCompleted(real x, real y, real width, real height)
    
    // Starting point indicator (black dot shown during rectangle drawing)
    Rectangle {
        id: startPointIndicator
        visible: tool.isDrawing
        x: tool.drawStartX - (6 / tool.zoomLevel)
        y: tool.drawStartY - (6 / tool.zoomLevel)
        width: 12 / tool.zoomLevel
        height: 12 / tool.zoomLevel
        radius: 6 / tool.zoomLevel
        color: "black"
        border.color: "white"
        border.width: 1 / tool.zoomLevel
    }
    
    // Preview rectangle with dashed border (shown while drawing)
    Item {
        id: previewRect
        visible: tool.currentRect !== null && 
                 tool.currentRect !== undefined &&
                 tool.currentRect.width > 0 &&
                 tool.currentRect.height > 0
        x: tool.currentRect ? tool.currentRect.x : 0
        y: tool.currentRect ? tool.currentRect.y : 0
        width: tool.currentRect ? tool.currentRect.width : 0
        height: tool.currentRect ? tool.currentRect.height : 0
        
        // Dashed border drawn with Canvas
        Canvas {
            id: dashedCanvas
            anchors.fill: parent
            
            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);
                
                if (width > 0 && height > 0) {
                    ctx.strokeStyle = "white";
                    ctx.lineWidth = 2 / tool.zoomLevel;
                    ctx.setLineDash([4 / tool.zoomLevel, 3 / tool.zoomLevel]);
                    ctx.strokeRect(0, 0, width, height);
                }
            }
            
            Component.onCompleted: requestPaint()
            
            Connections {
                target: previewRect
                function onWidthChanged() { dashedCanvas.requestPaint() }
                function onHeightChanged() { dashedCanvas.requestPaint() }
                function onVisibleChanged() { if (previewRect.visible) dashedCanvas.requestPaint() }
            }
            
            Connections {
                target: tool
                function onZoomLevelChanged() { dashedCanvas.requestPaint() }
            }
        }
    }
    
    // Handle clicks for rectangle drawing
    function handleClick(canvasX, canvasY) {
        if (!tool.active) return;
        
        if (!isDrawing) {
            // First click: Start drawing a rectangle
            isDrawing = true;
            drawStartX = canvasX;
            drawStartY = canvasY;
            
            console.log("Draw start:", drawStartX, drawStartY);
            
            // Initialize rectangle at start point with minimal size
            currentRect = {
                x: drawStartX,
                y: drawStartY,
                width: 1,
                height: 1
            };
        } else {
            // Second click: Finalize the rectangle
            if (currentRect && 
                currentRect.width > 1 && 
                currentRect.height > 1) {
                
                console.log("Finalizing rect:", currentRect.x, currentRect.y, 
                           currentRect.width, currentRect.height);
                
                // Emit signal with rectangle data
                rectangleCompleted(currentRect.x, currentRect.y, 
                                 currentRect.width, currentRect.height);
            }
            
            // Clear current rectangle and reset drawing state
            currentRect = null;
            isDrawing = false;
        }
    }
    
    // Update preview during mouse movement
    function handleMouseMove(canvasX, canvasY) {
        if (!tool.active || !isDrawing) return;
        
        // Calculate width and height from start point to current point
        var width = canvasX - drawStartX;
        var height = canvasY - drawStartY;
        
        // Handle dragging in any direction (normalize rectangle)
        var rectX = width >= 0 ? drawStartX : canvasX;
        var rectY = height >= 0 ? drawStartY : canvasY;
        var rectWidth = Math.abs(width);
        var rectHeight = Math.abs(height);
        
        // Update current rectangle (create new object to trigger binding)
        currentRect = {
            x: rectX,
            y: rectY,
            width: rectWidth,
            height: rectHeight
        };
    }
    
    // Reset tool state (called when switching tools)
    function reset() {
        isDrawing = false;
        currentRect = null;
    }
}

