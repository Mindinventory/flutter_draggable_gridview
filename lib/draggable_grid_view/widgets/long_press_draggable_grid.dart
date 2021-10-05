part of draggable_grid_view;

class LongPressDraggableGridView extends StatelessWidget {
  final int index;
  final Widget? feedback;
  final Widget? childWhenDragging;
  const LongPressDraggableGridView({Key? key, required this.index, this.feedback, this.childWhenDragging}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      onDragStarted: () {
        if (dragEnded) {
          dragStarted = true;
          dragEnded = false;
        }
      },
      onDragEnd: (details) {
        dragEnded = true;
        dragStarted = false;
      },
      data: index,
      feedback: feedback ?? list[index],
      child: list[index],
      childWhenDragging: (childWhenDragging!=null) ? childWhenDragging : (_draggedChild != null) ? _draggedChild : list[index],
    );
  }
}



