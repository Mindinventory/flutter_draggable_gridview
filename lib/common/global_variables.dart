part of draggable_grid_view;

var _dragStarted = false;
var _dragEnded = true;
late List<Widget> _orgList;
late List<Widget> _list;
Widget? _draggedChild;
int _draggedIndex = -1;
int _lastIndex = -1;
bool _draggedIndexRemoved = false;

/// [isOnlyLongPress] is Accepts 'true' and 'false'
/// If, it is true then only draggable works with long press.
/// and if it is false then it works with simple press.
bool _isOnlyLongPress = true;
