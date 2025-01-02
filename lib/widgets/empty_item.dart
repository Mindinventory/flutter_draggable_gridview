part of '../flutter_draggable_gridview.dart';

/// [EmptyItem] will use to show at drag target, when the widget is being dragged.
class EmptyItem extends StatelessWidget {
  const EmptyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.white);
  }
}
