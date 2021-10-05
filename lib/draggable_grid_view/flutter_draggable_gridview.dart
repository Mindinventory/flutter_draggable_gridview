library draggable_grid_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part 'widgets/drag_target_grid.dart';
part 'widgets/long_press_draggable_grid.dart';
part 'widgets/press_draggable_grid.dart';
part 'abstracts/drag_child_when_dragging.dart';
part 'abstracts/drag_feedback.dart';
part 'abstracts/drag_place_holder.dart';
part 'widgets/empty_item.dart';
part 'widgets/placeholder_widget.dart';


var dragStarted = false;
var dragEnded = true;
late List<Widget> orgList;
late List<Widget> list;
Widget? _draggedChild;
int draggedIndex = -1;
int lastIndex = -1;
bool draggedIndexRemoved = false;
bool isOnlyLongPress = true;

class DraggableGridViewBuilder extends StatefulWidget {

  final List<Widget> listOfWidgets;
  final bool isOnlyLongPress;
  final DragFeedback? dragFeedback;
  final DragChildWhenDragging? dragChildWhenDragging;
  final DragPlaceHolder? dragPlaceHolder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final SliverGridDelegate gridDelegate;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;

  const DraggableGridViewBuilder({
    Key? key,
    required this.gridDelegate,
    required this.listOfWidgets,
    this.isOnlyLongPress = true,
    this.dragFeedback,
    this.dragChildWhenDragging,
    this.dragPlaceHolder,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
  }) : super(
          key: key,
        );

  @override
  _DraggableGridViewBuilderState createState() =>
      _DraggableGridViewBuilderState();
}

class _DraggableGridViewBuilderState extends State<DraggableGridViewBuilder> {
  @override
  void initState() {
    super.initState();
    list = [...widget.listOfWidgets];
    orgList = [...widget.listOfWidgets];
    isOnlyLongPress = widget.isOnlyLongPress;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.addRepaintBoundaries,
      addSemanticIndexes: widget.addSemanticIndexes,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      gridDelegate: widget.gridDelegate,
      itemBuilder: (context, index) {
        return DragTargetGrid(
          index: index,
          voidCallback: () {
            setState(() {});
          },
          feedback: widget.dragFeedback?.feedback(index),
          childWhenDragging: widget.dragChildWhenDragging?.dragChildWhenDragging(index),
          placeHolder: widget.dragPlaceHolder?.placeHolder(index),
        );
      },
      itemCount: list.length,
    );
  }
}
