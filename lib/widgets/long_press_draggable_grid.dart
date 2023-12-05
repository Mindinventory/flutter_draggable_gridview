part of draggable_grid_view;

class LongPressDraggableGridView extends StatelessWidget {
  /// [index] is use to get item from the list.
  final int index;

  /// [feedback] this to display the widget when the widget is being dragged.
  final Widget? feedback;

  /// [DragChildWhenDragging] this to display the widget at dragged widget place when the widget is being dragged.
  final Widget? childWhenDragging;
  List<DraggableGridItem> list;

  final VoidCallback onDragCancelled;
  bool dragStarted;
  bool dragEnded;

  Function(bool) onDragStarted;
  Function(bool) onDragEnded;

  DraggableGridItem? draggedGridItem;

  LongPressDraggableGridView({
    required this.dragEnded,
    required this.dragStarted,
    required this.onDragEnded,
    required this.onDragStarted,
    required this.draggedGridItem,
    required this.index,
    required this.list,
    required this.onDragCancelled,
    this.feedback,
    this.childWhenDragging,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<(int, DraggableGridItem)>(
      onDraggableCanceled: (_, __) => onDragCancelled(),
      onDragCompleted: () {
        log('');
      },
      onDragStarted: () {
        if (dragEnded) {
          dragStarted = true;
          dragEnded = false;
          onDragStarted.call(true);
          onDragEnded.call(false);
        }
      },
      onDragEnd: (details) {
        dragEnded = true;
        dragStarted = false;
        onDragStarted.call(false);
        onDragEnded.call(true);
      },
      data: (index, list[index]),
      feedback: feedback ?? list[index].child,
      childWhenDragging: childWhenDragging ?? draggedGridItem?.child ?? list[index].child,
      child: list[index].child,
    );
  }
}
