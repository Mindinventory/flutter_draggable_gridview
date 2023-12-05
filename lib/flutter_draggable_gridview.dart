library draggable_grid_view;

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/constants/colors.dart';

part 'common/global_variables.dart';
part 'models/draggable_grid_item.dart';
part 'widgets/drag_target_grid.dart';
part 'widgets/empty_item.dart';
part 'widgets/long_press_draggable_grid.dart';
part 'widgets/placeholder_widget.dart';
part 'widgets/press_draggable_grid.dart';

typedef DragCompletion = void Function(List<DraggableGridItem> list, int beforeIndex, int afterIndex);
typedef DragFeedback = Widget Function(List<DraggableGridItem> list, int index);
typedef DragChildWhenDragging = Widget Function(List<DraggableGridItem> list, int index);
typedef DragPlaceHolder = PlaceHolderWidget Function(List<DraggableGridItem> list, int index);

class DraggableGridViewBuilder extends StatefulWidget {
  /// [children] will show the widgets in Gridview.builder.
  final List<DraggableGridItem> children;

  /// [isOnlyLongPress] is Accepts 'true' and 'false'
  final bool isOnlyLongPress;

  /// [dragFeedback] you can set this to display the widget when the widget is being dragged.
  final DragFeedback? dragFeedback;

  /// [dragChildWhenDragging] you can set this to display the widget at dragged widget place when the widget is being dragged.
  final DragChildWhenDragging? dragChildWhenDragging;

  /// [dragPlaceHolder] you can set this to display the widget at the drag target when the widget is being dragged.
  final DragPlaceHolder? dragPlaceHolder;

  /// [dragCompletion] you have to set this callback to get the updated list.
  final DragCompletion dragCompletion;

  /// all the below variables for Gridview.builder.
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
    required this.children,
    required this.dragCompletion,
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
  }) : super(key: key);

  @override
  DraggableGridViewBuilderState createState() => DraggableGridViewBuilderState();
}

class DraggableGridViewBuilderState extends State<DraggableGridViewBuilder> {
  bool _isOnlyLongPress = true;
  late List<DraggableGridItem> _list;
  DraggableGridItem? _draggedGridItem;
  late List<DraggableGridItem> _orgList;

  @override
  void initState() {
    super.initState();
    assert(widget.children.isNotEmpty, 'Children must not be empty.');

    /// [list] will update when the widget is beign dragged.
    _list = [...widget.children];

    /// [orgList] will set when the drag completes.
    _orgList = [...widget.children];
    _isOnlyLongPress = widget.isOnlyLongPress;
  }

  @override
  void didUpdateWidget(DraggableGridViewBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.children.isNotEmpty, 'Children must not be empty.');

    _list = [...widget.children];
    _orgList = [...widget.children];
    _isOnlyLongPress = widget.isOnlyLongPress;
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
      itemBuilder: (_, index) {
        return (!_list[index].isDraggable)
            ? _list[index].child
            : DragTargetGrid(
                index: index,
                onChangeCallback: () => setState(() {}),
                feedback: widget.dragFeedback?.call(_list, index),
                childWhenDragging: widget.dragChildWhenDragging?.call(_orgList, index),
                placeHolder: widget.dragPlaceHolder?.call(_orgList, index),
                dragCompletion: widget.dragCompletion,
                isOnlyLongPress: _isOnlyLongPress,
                list: _list,
                orgList: _orgList,
                draggedGridItem: _draggedGridItem,
                onDragGridItem: (DraggableGridItem? data) {
                  _draggedGridItem = data;
                  setState(() {});
                },
                onOrgListUpdate: (List<DraggableGridItem> data) {
                  _orgList = data;
                },
                onListUpdate: (List<DraggableGridItem> data) {
                  _list = data;
                },
              );
      },
      itemCount: _list.length,
    );
  }
}
