part of draggable_grid_view;

/// /// [PlaceHolderWidget] will use to show at drag target, when the widget is being dragged.
class PlaceHolderWidget extends StatelessWidget {
  final Widget child;
  const PlaceHolderWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
