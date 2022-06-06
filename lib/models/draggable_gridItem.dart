part of draggable_grid_view;

/// This class helps to manage widget and dragging enable/disable.
/// [child] will show the widgets in Gridview.builder.
/// [isDraggable] is boolean, you want to allow dragging then set it true or else false.
class DraggableGridItem<T> {
  DraggableGridItem({required this.child, this.isDraggable = false, this.data});

  final bool isDraggable;
  final Widget child;
  final T? data;
}
