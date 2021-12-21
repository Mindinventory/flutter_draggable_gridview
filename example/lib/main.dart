import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable GridView',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(
        title: 'Draggable GridView',
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

class MyHomePageState extends State<MyHomePage>
    with DragFeedback, DragPlaceHolder, DragCompletion {
  static List<String> listOfImages =
      List.generate(13, (index) => 'assets/${index + 1}.jpeg');

  List<Widget> listOfWidgets = [];

  @override
  void initState() {
    listOfWidgets.addAll(
      List.generate(
        listOfImages.length,
        (index) => Container(
          padding: EdgeInsets.only(
            left: 4.0,
            right: 4.0,
            top: 8.0,
          ),
          child: Image.asset(
            listOfImages[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    listOfWidgets.insert(
      5,
      UndraggableWidget(
        child: Container(
          padding: EdgeInsets.only(
            left: 4.0,
            right: 4.0,
            top: 8.0,
          ),
          child: Image.asset(
            'assets/1.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
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
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        listOfWidgets: listOfWidgets,
        dragCompletion: this,
        isOnlyLongPress: false,
        dragFeedback: this,
        dragPlaceHolder: this,
      ),
    );
  }

  @override
  Widget feedback(List<Widget> list, int index) {
    // If widget is UndraggableWidget then return as it is.
    if(list[index] is UndraggableWidget) return list[index];

    // If widget is Draggable then below code will execute.
    var item = list[index] as Container;
    return Container(
      child: item.child,
      width: 200,
      height: 150,
    );
  }

  @override
  PlaceHolderWidget placeHolder(List<Widget> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.white,
      ),
    );
  }

  @override
  void onDragAccept(List<Widget> list) {
    // print(list);
  }
}
