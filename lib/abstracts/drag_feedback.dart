part of draggable_grid_view;

/// [DragFeedback] you can use this to display the widget when the widget is being dragged.
abstract class DragFeedback {
  Widget feedback(List<DraggableGridItem> list, int index);
}
