part of draggable_grid_view;

/// [DragChildWhenDragging] you can use this to display the widget at dragged widget place when the widget is being dragged.
abstract class DragChildWhenDragging<T> {
  Widget dragChildWhenDragging(List<DraggableGridItem<T>> list, int index);
}
