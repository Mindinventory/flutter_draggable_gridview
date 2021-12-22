import 'package:example/constants/colors.dart';
import 'package:example/constants/dimens.dart';
import 'package:example/constants/images.dart';
import 'package:example/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_title,
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor,
      ),
      home: MyHomePage(
        title: Strings.app_title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with DragFeedback, DragPlaceHolder, DragCompletion {
  List<DraggableGridItem> _listOfDraggableGridItem = [];

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
        title: Text(
          widget.title,
        ),
      ),
      body: DraggableGridViewBuilder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 3),
        ),
        children: _listOfDraggableGridItem,
        dragCompletion: this,
        isOnlyLongPress: false,
        dragFeedback: this,
        dragPlaceHolder: this,
      ),
    );
  }

  @override
  Widget feedback(List<DraggableGridItem> list, int index) {
    return Container(
      child: list[index].child,
      width: 200,
      height: 150,
    );
  }

  @override
  PlaceHolderWidget placeHolder(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.white,
      ),
    );
  }

  @override
  void onDragAccept(List<DraggableGridItem> list) {

  }

  void _generateImageData() {
    _listOfDraggableGridItem.addAll(
      [
        DraggableGridItem(child: _GridItem(image: Images.asset_1), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_2), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_3), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_4), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_5), isDraggable: false),
        DraggableGridItem(child: _GridItem(image: Images.asset_6), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_7), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_8), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_9), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_10), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_11), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_12), isDraggable: true),
        DraggableGridItem(child: _GridItem(image: Images.asset_13), isDraggable: true),
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({required this.image, Key? key}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.padding_small,
        vertical: Dimens.padding_small,
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
