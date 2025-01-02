part of '../flutter_draggable_gridview.dart';

/// /// [PlaceHolderWidget] will use to show at drag target, when the widget is being dragged.
class PlaceHolderWidget extends StatelessWidget {
  final Widget child;
  const PlaceHolderWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
