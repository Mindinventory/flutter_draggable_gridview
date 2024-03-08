part of '../flutter_draggable_gridview.dart';

//ignore: must_be_immutable
class PressDraggableGridView extends StatelessWidget {
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

  PressDraggableGridView(
      {super.key,
      required this.index,
      required this.onDragCancelled,
      this.feedback,
      this.childWhenDragging,
      required this.dragStarted,
      required this.draggedGridItem,
      required this.dragEnded,
      required this.list,
      required this.onDragEnded,
      required this.onDragStarted});

  @override
  Widget build(BuildContext context) {
    return Draggable<(int, DraggableGridItem)>(
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
