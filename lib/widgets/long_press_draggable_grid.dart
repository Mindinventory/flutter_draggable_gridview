part of draggable_grid_view;

//ignore: must_be_immutable
class LongPressDraggableGridView extends StatelessWidget {
  final int index;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final VoidCallback onDragCancelled;
  var dragStarted = false;
  final Function(bool) onDragStarted;
  final Function(bool) onDragEnded;
  var dragEnded = true;
  DraggableGridItem? draggedGridItem;
  List<DraggableGridItem> list;

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
      onDragStarted: () {
        if (dragEnded) {
          dragStarted = true;
          dragEnded = false;
          onDragEnded.call(false);
          onDragStarted.call(true);
        }
      },
      onDragEnd: (details) {
        dragEnded = true;
        dragStarted = false;
        onDragEnded.call(true);
        onDragStarted.call(false);
      },
      data: (index, list[index]),
      feedback: feedback ?? list[index].child,
      childWhenDragging:
          childWhenDragging ?? draggedGridItem?.child ?? list[index].child,
      child: list[index].child,
    );
  }
}
