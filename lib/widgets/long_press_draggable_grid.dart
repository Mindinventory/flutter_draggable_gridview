part of draggable_grid_view;

class LongPressDraggableGridView extends StatelessWidget {
  /// [index] is use to get item from the list.
  final int index;

  /// [feedback] this to display the widget when the widget is being dragged.
  final Widget? feedback;

  /// [DragChildWhenDragging] this to display the widget at dragged widget place when the widget is being dragged.
  final Widget? childWhenDragging;

  final VoidCallback onDragCancelled;

  const LongPressDraggableGridView({
    required this.index,
    required this.onDragCancelled,
    this.feedback,
    this.childWhenDragging,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      onDraggableCanceled: (_, __) => onDragCancelled(),
      onDragCompleted: () {
        log('');
      },
      onDragStarted: () {
        if (_dragEnded) {
          _dragStarted = true;
          _dragEnded = false;
        }
      },
      onDragEnd: (details) {
        _dragEnded = true;
        _dragStarted = false;
      },
      data: index,
      feedback: feedback ?? _list[index].child,
      childWhenDragging:
          childWhenDragging ?? _draggedGridItem?.child ?? _list[index].child,
      child: _list[index].child,
    );
  }
}
