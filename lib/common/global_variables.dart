part of draggable_grid_view;

var _dragStarted = false;
var _dragEnded = true;
late List<DraggableGridItem> _orgList;
late List<DraggableGridItem> _list;
DraggableGridItem? _draggedGridItem;
int _draggedIndex = -1;
int _lastIndex = -1;
bool _draggedIndexRemoved = false;

/// [isOnlyLongPress] is Accepts 'true' and 'false'
/// If, it is true then only draggable works with long press.
/// and if it is false then it works with simple press.
bool _isOnlyLongPress = true;
