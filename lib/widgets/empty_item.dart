part of draggable_grid_view;

/// [EmptyItem] will use to show at drag target, when the widget is being dragged.
class EmptyItem extends StatelessWidget {
  const EmptyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
