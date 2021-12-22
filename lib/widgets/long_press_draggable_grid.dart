part of draggable_grid_view;

class LongPressDraggableGridView extends StatelessWidget {
  final int index;
  final Widget? feedback;
  final Widget? childWhenDragging;

  const LongPressDraggableGridView({required this.index, this.feedback, this.childWhenDragging, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
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
      child: _list[index].child,
      childWhenDragging: childWhenDragging ?? _draggedGridItem?.child ?? _list[index].child,
    );
  }
}
