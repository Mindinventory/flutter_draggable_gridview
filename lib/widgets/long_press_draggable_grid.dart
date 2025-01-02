part of '../flutter_draggable_gridview.dart';

class LongPressDraggableGridView extends StatelessWidget {
  /// [index] is use to get item from the list.
  final int index;

  /// [feedback] this to display the widget when the widget is being dragged.
  final Widget? feedback;

  /// [DragChildWhenDragging] this to display the widget at dragged widget place when the widget is being dragged.
  final Widget? childWhenDragging;

  final VoidCallback onDragCancelled;

  final List<DraggableGridItem> list;

  const LongPressDraggableGridView(
      {required this.index,
      required this.onDragCancelled,
      this.feedback,
      this.childWhenDragging,
      super.key,
      required this.list});

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
      data: (index, list[index]),
      feedback: feedback ?? list[index].child,
      childWhenDragging:
          childWhenDragging ?? _draggedGridItem?.child ?? list[index].child,
      child: list[index].child,
    );
  }
}
