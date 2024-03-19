part of '../flutter_draggable_gridview.dart';

class PressDraggableGridView extends StatelessWidget {
  final int index;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final VoidCallback onDragCancelled;

  final List<DraggableGridItem> list;

  const PressDraggableGridView({
    super.key,
    required this.index,
    required this.onDragCancelled,
    this.feedback,
    this.childWhenDragging,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<(int, DraggableGridItem)>(
      onDraggableCanceled: (_, __) => onDragCancelled(),
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
      data: (index, list[index]),
      feedback: feedback ?? list[index].child,
      childWhenDragging:
          childWhenDragging ?? _draggedGridItem?.child ?? list[index].child,
      child: list[index].child,
    );
  }
}
