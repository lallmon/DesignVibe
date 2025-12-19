# DesignVibe

A digital design application built with PySide6 and Qt Quick.

## Features

### Rendering Canvas
- **Infinite canvas** with pan and zoom capabilities
- **Grid system** with minor and major gridlines for visual reference
- **Zoom controls**: Mouse wheel, keyboard shortcuts (Ctrl+/Ctrl-/Ctrl+0), and menu options
- **Pan navigation**: Click and drag with left mouse button
- **Crisp rendering** with smooth transformations
- Starts at 100% zoom level

### Drawing Tools
- **Rectangle tool**: Draw vector rectangles on the canvas
  - Red stroke (2px width) for finalized shapes
  - Dotted red preview while dragging
  - Click and drag to create rectangles
  - Proper coordinate transformation with zoom and pan
  - Stroke width scales inversely with zoom for consistent appearance

### User Interface
- Menu bar with File and View menus
- Left vertical tool palette with drawing tools
- Right resizable panel for object properties (128-256px, default 220px)
- Status bar with real-time zoom level and cursor position
- Tool settings bar for active tool options


## Controls

### Navigation
- **Pan**: Click and drag with left mouse button (when no tool is selected)
- **Zoom**: Mouse wheel or Ctrl+Plus/Ctrl+Minus
- **Reset view**: Ctrl+0
- **Quit**: Ctrl+Q

### Tools
- **Select tool**: Click the "Sel" button to enable pan and zoom mode
- **Rectangle tool**: Click the "Rect" button to draw rectangles
  - Click and drag on the canvas to draw
  - Rectangle appears with dotted preview while dragging
  - Solid red outline when finalized

## Project Structure

- `main.py` - Application entry point
- `main.qml` - Main application window with menu bar and layout
- `components/` - QML components directory
  - `Canvas.qml` - Canvas component with pan/zoom and drawing
  - `Viewport.qml` - Viewport with zoom/pan transforms and grid
  - `MenuBar.qml` - Application menu bar with File and View menus
  - `StatusBar.qml` - Status bar component with zoom level and cursor position
  - `ToolSettings.qml` - Context-sensitive tool settings bar
  - `ToolPalette.qml` - Left tool palette with drawing tool buttons
  - `RightPanel.qml` - Right resizable panel for object properties
  - `SelectTool.qml` - Select/pan tool implementation
  - `RectangleTool.qml` - Rectangle drawing tool implementation
  - `Theme.qml` - Centralized UI constants and styling
  - `PhIcon.qml` - SVG icon component using Phosphor icons
- `canvas_renderer.py` - QPainter-based canvas renderer
- `canvas_items.py` - Canvas item data structures
- `pyproject.toml` - Project configuration
- `requirements.txt` - Python dependencies

