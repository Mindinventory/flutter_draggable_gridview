import 'dart:developer';

import 'package:example/constants/images.dart';
import 'package:flutter/cupertino.dart';
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
  final List<DraggableGridItem> _listOfDraggableGridItem2 = [];

  @override
  void initState() {
    _generateImageData1();
    _generateImageData2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: DraggableGridViewBuilder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                ),
                children: _listOfDraggableGridItem,
                dragCompletion: onDragAccept,
                isOnlyLongPress: true,
                dragFeedback: feedback,
                dragPlaceHolder: placeHolder,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: DraggableGridViewBuilder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 3),
                ),
                children: _listOfDraggableGridItem2,
                dragCompletion: onDragAccept2,
                isOnlyLongPress: true,
                dragFeedback: feedback2,
                dragPlaceHolder: placeHolder2,
              ),
            ),
          ],
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

  Widget feedback2(List<DraggableGridItem> list, int index) {
    return SizedBox(
      width: 200,
      height: 150,
      child: list[index].child,
    );
  }

  PlaceHolderWidget placeHolder2(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.green,
      ),
    );
  }

  void onDragAccept2(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    log('onDragAccept: $beforeIndex -> $afterIndex');
  }

  void _generateImageData1() {
    _listOfDraggableGridItem.addAll(
      [
        DraggableGridItem(
          child: const GridItem(image: Images.asset_1),
          isDraggable: true,
          dragCallback: (context, isDragging) {
            log('isDragging: $isDragging');
          },
        ),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_2), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_3), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_4), isDraggable: true),
      ],
    );
  }

  void _generateImageData2() {
    _listOfDraggableGridItem2.addAll(
      [
        DraggableGridItem(
            child: const GridItem(image: Images.asset_6), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_7), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_8), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_9), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_10), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_11), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_12), isDraggable: true),
        DraggableGridItem(
            child: const GridItem(image: Images.asset_13), isDraggable: true),
      ],
    );
  }
}
