part of '../flutter_draggable_gridview.dart';

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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<(int, DraggableGridItem)>(
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
