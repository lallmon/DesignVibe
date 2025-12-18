import QtQuick
import QtQuick.Controls

// Select tool component - handles panning and object selection
Item {
    id: tool
    
    // Properties
    property bool active: false
    
    // Internal state
    property bool isPanning: false
    property real lastX: 0
    property real lastY: 0
    
    // Signals
    signal panDelta(real dx, real dy)
    signal cursorShapeChanged(int shape)
    
    // Handle mouse press for panning
    function handlePress(screenX, screenY, button) {
        if (!tool.active) return false;
        
        if (button === Qt.LeftButton || button === Qt.MiddleButton) {
            isPanning = true;
            lastX = screenX;
            lastY = screenY;
            cursorShapeChanged(Qt.ClosedHandCursor);
            return true;  // Event handled
        }
        
        return false;
    }
    
    // Handle mouse release
    function handleRelease(screenX, screenY, button) {
        if (!tool.active) return false;
        
        if (isPanning) {
            isPanning = false;
            cursorShapeChanged(Qt.ArrowCursor);
            return true;  // Event handled
        }
        
        return false;
    }
    
    // Handle mouse movement for panning
    function handleMouseMove(screenX, screenY) {
        if (!tool.active) return false;
        
        if (isPanning) {
            var dx = screenX - lastX;
            var dy = screenY - lastY;
            
            panDelta(dx, dy);
            
            lastX = screenX;
            lastY = screenY;
            return true;  // Event handled
        }
        
        return false;
    }
    
    // Reset tool state
    function reset() {
        isPanning = false;
    }
}

