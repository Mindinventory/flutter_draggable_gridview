part of draggable_grid_view;

class PressDraggableGridView extends StatelessWidget {
  final int index;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final VoidCallback onDragCancelled;

  const PressDraggableGridView({
    Key? key,
    required this.index,
    this.feedback,
    this.childWhenDragging,
    required this.onDragCancelled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      onDraggableCanceled: (velocity, offset) {
        onDragCancelled();
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
      feedback: feedback ?? _list[index],
      child: _list[index],
      childWhenDragging: (childWhenDragging != null)
          ? childWhenDragging
          : (_draggedChild != null)
              ? _draggedChild
              : _list[index],
    );
  }
}
