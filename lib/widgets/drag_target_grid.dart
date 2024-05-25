part of draggable_grid_view;

//ignore: must_be_immutable
class DragTargetGrid extends StatefulWidget {
  final int index;
  final VoidCallback? onChangeCallback;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final PlaceHolderWidget? placeHolder;
  final DragCompletion? dragCompletion;
  final DraggableGridItem? draggedGridItem;
  final Function(List<DraggableGridItem>) onListUpdate;
  final Function(List<DraggableGridItem>) onOrgListUpdate;
  final Function(DraggableGridItem?) onDragGridItem;

  final bool isOnlyLongPress;
  final List<DraggableGridItem> list;
  late List<DraggableGridItem> orgList;

  DragTargetGrid({
    Key? key,
    required this.list,
    required this.draggedGridItem,
    required this.onDragGridItem,
    required this.index,
    required this.orgList,
    required this.onOrgListUpdate,
    required this.onListUpdate,
    required this.onChangeCallback,
    this.feedback,
    this.childWhenDragging,
    this.placeHolder,
    required this.isOnlyLongPress,
    required this.dragCompletion,
  }) : super(key: key);

  @override
  DragTargetGridState createState() => DragTargetGridState();
}

class DragTargetGridState extends State<DragTargetGrid> {
  static bool _draggedIndexRemoved = false;
  static int _lastIndex = -1;
  static int _draggedIndex = -1;
  var _dragStarted = false;
  var _dragEnded = true;
  DraggableGridItem? _draggedGridItem;
  late DragTargetDetails<(int, DraggableGridItem)> object;

  @override
  void initState() {
    _draggedGridItem = widget.draggedGridItem;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<(int, DraggableGridItem)>(
      /// When drag is completes and other item index is ready to accept it.
      onAcceptWithDetails: (data) => setState(() {
        _onDragComplete(widget.index);
      }),
      onLeave: (details) {},

      /// Drag is acceptable in this index else this place.
      onWillAcceptWithDetails: (details) {
        return widget.orgList.contains(details);
      },
      onMove: (details) {
        if (widget.orgList.contains(details.data.$2)) {
          widget.orgList[widget.index].dragCallback?.call(context, true);

          /// Update state when item is moving.
          setState(() {
            _setDragStartedData(details, widget.index);
            _checkIndexesAreDifferent(details, widget.index);
            widget.onChangeCallback?.call();
          });
        }
      },
      builder: (BuildContext context, List<dynamic> accepted,
          List<dynamic> rejected) {
        /// [_isOnlyLongPress] is true then set the 'LongPressDraggableGridView' class or else set 'PressDraggableGridView' class.
        return (widget.isOnlyLongPress)
            ? LongPressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
                onDragCancelled: () => _onDragComplete(_lastIndex),
                dragStarted: _dragStarted,
                dragEnded: _dragEnded,
                onDragEnded: (bool data) {
                  _dragEnded = data;
                  setState(() {});
                },
                onDragStarted: (bool data) {
                  _dragStarted = data;
                  setState(() {});
                },
                list: widget.list,
                draggedGridItem: _draggedGridItem,
              )
            : PressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
                onDragCancelled: () => _onDragComplete(_lastIndex),
                dragStarted: _dragStarted,
                dragEnded: _dragEnded,
                onDragEnded: (bool data) {
                  _dragEnded = data;
                  setState(() {});
                },
                onDragStarted: (bool data) {
                  _dragStarted = data;
                  setState(() {});
                },
                list: widget.list,
                draggedGridItem: _draggedGridItem,
              );
      },
    );
  }

  /// Set drag data when dragging start.
  void _setDragStartedData(
      DragTargetDetails<(int, DraggableGridItem)> details, int index) {
    if (_dragStarted) {
      _dragStarted = false;
      _draggedIndexRemoved = false;
      _draggedIndex = details.data.$1;
      _draggedGridItem = DraggableGridItem(
          child: widget.placeHolder ?? const EmptyItem(), isDraggable: true);
      _lastIndex = _draggedIndex;
      widget.onDragGridItem.call(_draggedGridItem);
    }
  }

  /// When [_draggedIndex] and [_lastIndex] both are different that means item is dragged and travelling to other place.
  void _checkIndexesAreDifferent(
      DragTargetDetails<(int, DraggableGridItem)> details, int index) {
    /// Here, check [_draggedIndex] is != -1.
    /// And also check index is not equal to _lastIndex. Means if both will true then skip it. else do some operations.

    if (_draggedIndex != -1 && index != _lastIndex) {
      widget.list.removeWhere((element) {
        return (widget.placeHolder != null)
            ? element.child is PlaceHolderWidget
            : element.child is EmptyItem;
      });

      /// store _lastIndex as index.
      /// Means draggedIndex is 6 and dragged child is at index 4 then set _lastIndex to 4.
      _lastIndex = index;

      /// Here, we are checking _draggedIndex is greater than _lastIndex.
      /// For ex:
      /// If _draggedIndex is 6 and _lastIndex = 4 then _draggedChild will be 5.
      if (_draggedIndex > _lastIndex) {
        _draggedGridItem = widget.orgList[_draggedIndex - 1];
      } else {
        _draggedGridItem = widget.orgList[
            (_draggedIndex + 1 >= widget.list.length)
                ? _draggedIndex
                : _draggedIndex + 1];
      }

      /// If dragged index and current index both are same then show place holder widget(if user it overridden). else show EmptyItem class.
      if (_draggedIndex == _lastIndex) {
        _draggedGridItem = DraggableGridItem(
            child: widget.placeHolder ?? const EmptyItem(), isDraggable: true);
      }

      if (!_draggedIndexRemoved) {
        _draggedIndexRemoved = true;
        widget.list.removeAt(_draggedIndex);
      }
      widget.list.insert(
        _lastIndex,
        DraggableGridItem(
            child: widget.placeHolder ?? const EmptyItem(), isDraggable: true),
      );
    }
    widget.onDragGridItem.call(_draggedGridItem);

// /// Here, check [_draggedIndex] is != -1.
// /// And also check index is not equal to _lastIndex. Means if both will true then skip it. else do some operations.
// if (_draggedIndex != -1 && index != _lastIndex) {
//   widget.list.removeWhere((element) {
//     return (widget.placeHolder != null) ? element.child is PlaceHolderWidget : element.child is EmptyItem;
//   });
//
//   /// store _lastIndex as index.
//   /// Means draggedIndex is 6 and dragged child is at index 4 then set _lastIndex to 4.
//   _lastIndex = index;
//
//   /// Here, we are checking _draggedIndex is greater than _lastIndex.
//   /// For ex:
//   /// If _draggedIndex is 6 and _lastIndex = 4 then _draggedChild will be 5.
//   if (_draggedIndex > _lastIndex) {
//     _draggedGridItem = widget.orgList[_draggedIndex - 1];
//   } else {
//     _draggedGridItem = widget.orgList[(_draggedIndex + 1 >= widget.list.length) ? _draggedIndex : _draggedIndex + 1];
//   }
//
//   /// If dragged index and current index both are same then show place holder widget(if user it overridden). else show EmptyItem class.
//   if (_draggedIndex == _lastIndex) {
//     _draggedGridItem = DraggableGridItem(child: widget.placeHolder ?? const EmptyItem(), isDraggable: true);
//   }
//
//   if (!_draggedIndexRemoved) {
//     _draggedIndexRemoved = true;
//     widget.list.removeAt(_draggedIndex);
//   }
//   widget.list.insert(
//     _lastIndex,
//     DraggableGridItem(child: widget.placeHolder ?? const EmptyItem(), isDraggable: true),
//   );
// }
// widget.onDragGridItem.call(_draggedGridItem);
  }

  /// This method will execute when dragging is completes or else dragging is cancelled.
  void _onDragComplete(int index) {
    if (_draggedIndex == -1) return;
    widget.list.removeAt(index);
    widget.list.insert(index, widget.orgList[_draggedIndex]);
    widget.orgList = [...widget.list];
    _dragStarted = false;

    widget.onChangeCallback?.call();
    widget.list[index].dragCallback?.call(context, false);
    widget.dragCompletion?.call(widget.orgList, _draggedIndex, _lastIndex);
    _draggedIndex = -1;
    _lastIndex = -1;
    _draggedGridItem = null;
    widget.onDragGridItem.call(_draggedGridItem);
    widget.onOrgListUpdate.call(widget.orgList);
    widget.onListUpdate.call(widget.list);
  }
}
