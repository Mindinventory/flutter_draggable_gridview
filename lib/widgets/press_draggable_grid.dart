part of '../flutter_draggable_gridview.dart';

class PressDraggableGridView extends StatelessWidget {
  final int index;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final VoidCallback onDragCancelled;

  const PressDraggableGridView({
    super.key,
    required this.index,
    required this.onDragCancelled,
    this.feedback,
    this.childWhenDragging,
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
      data: (index, _list[index]),
      feedback: feedback ?? _list[index].child,
      childWhenDragging:
          childWhenDragging ?? _draggedGridItem?.child ?? _list[index].child,
      child: _list[index].child,
    );
  }
}
