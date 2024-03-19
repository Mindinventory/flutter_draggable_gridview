part of '../flutter_draggable_gridview.dart';

bool _dragStarted = false;
bool _dragEnded = true;
DraggableGridItem? _draggedGridItem;

// /// [isOnlyLongPress] is Accepts 'true' and 'false'
// /// If, it is true then only draggable works with long press.
// /// and if it is false then it works with simple press.
bool _isOnlyLongPress = true;
