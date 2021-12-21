part of draggable_grid_view;

/// [UndraggableWidget] will use to show at drag target, when the widget is being dragged.
class UndraggableWidget extends StatelessWidget {
  const UndraggableWidget({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
