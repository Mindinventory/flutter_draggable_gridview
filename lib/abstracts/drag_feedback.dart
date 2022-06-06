part of draggable_grid_view;

/// [DragFeedback] you can use this to display the widget when the widget is being dragged.
abstract class DragFeedback<T> {
  Widget feedback(List<DraggableGridItem<T>> list, int index);
}
