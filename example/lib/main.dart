import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/draggable_grid_view/flutter_draggable_gridview.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag & Drop In Grid View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Drag & Drop In Grid View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with DragFeedback, DragChildWhenDragging, DragPlaceHolder {

  var list = [
    Container(
      color: Colors.black,
      height: 200,
      width: 200,
    ),
    Container(
      color: Colors.grey,
      height: 200,
      width: 200,
    ),
    Container(
      color: Colors.red,
      height: 200,
      width: 200,
    ),
    Container(
      color: Colors.yellow,
      height: 200,
      width: 200,
    ),
    Container(
      color: Colors.blue,
      height: 200,
      width: 200,
    ),
    Container(
      color: Colors.black12,
      height: 200,
      width: 200,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: DraggableGridViewBuilder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        listOfWidgets: list,
        isOnlyLongPress: false,
        dragFeedback: this,
        dragChildWhenDragging: this,
        dragPlaceHolder: this,
      ),
    );
  }

  @override
  Widget feedback(int index) {
    return Container(color: list[index].color, width: 250, height: 250,);
  }

  @override
  Widget dragChildWhenDragging(int index) {
    return Container(color: Colors.white,);
  }

  @override
  PlaceHolderWidget placeHolder(int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.black12,
      ),
    );
  }

}
