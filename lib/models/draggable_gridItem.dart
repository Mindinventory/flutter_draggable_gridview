part of draggable_grid_view;

class DraggableGridItem {
  DraggableGridItem({required this.child, this.isDraggable = false});

  final bool isDraggable;
  final Widget child;
}
