part of draggable_grid_view;

class DragTargetGrid extends StatefulWidget {
  final int index;
  final VoidCallback voidCallback;
  final Widget? feedback;
  final Widget? childWhenDragging;
  // final Widget? placeHolder;
  final PlaceHolderWidget? placeHolder;

  const DragTargetGrid({
    Key? key,
    required this.index,
    required this.voidCallback,
    this.feedback,
    this.childWhenDragging,
    this.placeHolder,
  }) : super(key: key);

  @override
  _DragTargetGridState createState() => _DragTargetGridState();
}

class _DragTargetGridState extends State<DragTargetGrid> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (data) => setState(() {
        list.removeAt(widget.index);
        list.insert(
          widget.index,
          orgList[draggedIndex],
        );
        orgList = [...list];
        dragStarted = false;
        draggedIndex = -1;
        widget.voidCallback();
      }),
      onWillAccept: (details) {
        return true;
      },
      onMove: (details) {
        setState(() {
          setDragStartedData(details, widget.index);
          checkIndexesAreSame(details, widget.index);
          widget.voidCallback();
        });
      },
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return (isOnlyLongPress)
            ? LongPressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
              )
            : PressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
              );
      },
    );
  }

  void setDragStartedData(DragTargetDetails details, int index) {
    if (dragStarted) {
      dragStarted = false;
      draggedIndexRemoved = false;
      draggedIndex = details.data;
      _draggedChild = EmptyItem();
      lastIndex = draggedIndex;
    }
  }

  void checkIndexesAreSame(DragTargetDetails details, int index) {
    if (draggedIndex != -1 && index != lastIndex) {
      list.removeWhere((element) {
        // return (widget.placeHolder!=null) ? element==widget.placeHolder : element is EmptyItem;
        return (widget.placeHolder!=null) ? element is PlaceHolderWidget : element is EmptyItem;
      });
      lastIndex = index;

      if (draggedIndex > lastIndex) {
        _draggedChild = orgList[draggedIndex - 1];
      } else {
        _draggedChild = orgList[(draggedIndex + 1 >= list.length)
            ? draggedIndex
            : draggedIndex + 1];
      }
      if (draggedIndex == lastIndex) {
        _draggedChild = widget.placeHolder ?? EmptyItem();
      }
      if (!draggedIndexRemoved) {
        draggedIndexRemoved = true;
        list.removeAt(draggedIndex);
      }
      list.insert(
        lastIndex,
        widget.placeHolder ?? EmptyItem(),
      );
    }
  }

}
