part of draggable_grid_view;

/// [DragCompletion] you have to use this callback to get the updated list.
abstract class DragCompletion {
  void onDragAccept(List<DraggableGridItem> list);
}
