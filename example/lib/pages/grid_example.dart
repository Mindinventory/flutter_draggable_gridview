import 'dart:developer';

import 'package:example/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

import '../widgets/grid_item_widget.dart';

class GridExample extends StatefulWidget {
  const GridExample({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  GridExampleState createState() => GridExampleState();
}

class GridExampleState extends State<GridExample> {
  final List<DraggableGridItem> _listOfDraggableGridItem = [];

  @override
  void initState() {
    _generateImageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: DraggableGridViewBuilder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 3),
          ),
          children: _listOfDraggableGridItem,
          dragCompletion: onDragAccept,
          isOnlyLongPress: false,
          dragFeedback: feedback,
          dragPlaceHolder: placeHolder,
        ),
      ),
    );
  }

  Widget feedback(List<DraggableGridItem> list, int index) {
    return SizedBox(
      width: 200,
      height: 150,
      child: list[index].child,
    );
  }

  PlaceHolderWidget placeHolder(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.white,
      ),
    );
  }

  void onDragAccept(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    log('onDragAccept: $beforeIndex -> $afterIndex');
  }

  void _generateImageData() {
    _listOfDraggableGridItem.addAll(
      [
        DraggableGridItem(
          index: 0,
          child: const GridItem(image: Images.asset_1),
          isDraggable: true,
          dragCallback: (context, isDragging) {
            log('isDragging: $isDragging');
          },
        ),
        DraggableGridItem(
            index: 1,
            child: const GridItem(image: Images.asset_2),
            isDraggable: true),
        DraggableGridItem(
            index: 2,
            child: const GridItem(image: Images.asset_3),
            isDraggable: true),
        DraggableGridItem(
            index: 3,
            child: const GridItem(image: Images.asset_4),
            isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_5), isDraggable: false),
        // DraggableGridItem(child: const GridItem(image: Images.asset_6), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_7), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_8), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_9), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_10), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_11), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_12), isDraggable: true),
        // DraggableGridItem(child: const GridItem(image: Images.asset_13), isDraggable: true),
      ],
    );
  }
}
