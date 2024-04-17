part of '../flutter_draggable_gridview.dart';

class DragTargetGrid extends StatefulWidget {
  final int index;
  final VoidCallback? onChangeCallback;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final PlaceHolderWidget? placeHolder;
  final DragCompletion? dragCompletion;
  final ValueChanged<List<DraggableGridItem>> onListUpdate;
  final ValueChanged<List<DraggableGridItem>> onOrgListUpdate;

  const DragTargetGrid({
    super.key,
    required this.index,
    required this.onChangeCallback,
    this.feedback,
    this.childWhenDragging,
    this.placeHolder,
    required this.dragCompletion,
    required this.onListUpdate,
    required this.onOrgListUpdate,
  });

  @override
  DragTargetGridState createState() => DragTargetGridState();
}

class DragTargetGridState extends State<DragTargetGrid> {
  static bool _draggedIndexRemoved = false;
  static int _lastIndex = -1;
  static int _draggedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return DragTarget<(int, DraggableGridItem)>(
      /// When drag is completes and other item index is ready to accept it.
      onAcceptWithDetails: (details) {
        setState(() {
          _onDragComplete(widget.index);
        });
      },

      /// Drag is acceptable in this index else this place.
      onWillAcceptWithDetails: (details) {
        return _orgList.contains(details.data.$2);
      },
      onMove: (details) {
        if (_orgList.contains(details.data.$2)) {
          _orgList[widget.index].dragCallback?.call(context, true);

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
        return (_isOnlyLongPress)
            ? LongPressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
                onDragCancelled: () => _onDragComplete(_lastIndex),
              )
            : PressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
                onDragCancelled: () => _onDragComplete(_lastIndex),
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
    }
  }

  /// When [_draggedIndex] and [_lastIndex] both are different that means item is dragged and travelling to other place.
  void _checkIndexesAreDifferent(
      DragTargetDetails<(int, DraggableGridItem)> details, int index) {
    /// Here, check [_draggedIndex] is != -1.
    /// And also check index is not equal to _lastIndex. Means if both will true then skip it. else do some operations.
    if (_draggedIndex != -1 && index != _lastIndex) {
      _list.removeWhere((element) {
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
        _draggedGridItem = _orgList[_draggedIndex - 1];
      } else {
        _draggedGridItem = _orgList[(_draggedIndex + 1 >= _list.length)
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
        _list.removeAt(_draggedIndex);
      }
      _list.insert(
        _lastIndex,
        DraggableGridItem(
            child: widget.placeHolder ?? const EmptyItem(), isDraggable: true),
      );
    }
  }

  /// This method will execute when dragging is completes or else dragging is cancelled.
  void _onDragComplete(int index) {
    if (_draggedIndex == -1) return;
    _list.removeAt(index);
    _list.insert(index, _orgList[_draggedIndex]);

    _orgList = _list.toList();
    _dragStarted = false;

    widget.onListUpdate.call(_list);
    widget.onOrgListUpdate.call(_orgList);
    widget.onChangeCallback?.call();

    widget.dragCompletion?.call(_orgList, _draggedIndex, _lastIndex);

    _draggedIndex = -1;
    _lastIndex = -1;
    _draggedGridItem = null;
  }
}
