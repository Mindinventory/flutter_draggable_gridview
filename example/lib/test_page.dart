// import 'dart:io';
//
// import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cached_network_image/cached_network_image.dart';
//
// class SelectImage extends StatefulWidget {
//   const SelectImage({Key? key}) : super(key: key);
//
//   @override
//   State<SelectImage> createState() => _SelectImageState();
// }
//
// class _SelectImageState extends State<SelectImage> {
//   final ImagePicker picker = ImagePicker();
//
//   flip_Open(value) {
//     return !value;
//   }
//
//   List ReturnList = [];
//   List return_list = [];
//   List ImageOpenList = [];
//   Map ImageNetworkpnghrefMatch = {};
//
//   //어떤 사진을 넣어야하는지에 대해..아이콘 참고용
//   List IconList = [
//     Icons.sports_tennis_rounded,
//     Icons.flight_takeoff_rounded,
//     Icons.soup_kitchen_rounded,
//     Icons.liquor_rounded,
//     Icons.redeem_rounded,
//     // Icons.menu_book_rounded,
//     Icons.pets_rounded,
//     Icons.fitness_center_rounded,
//     Icons.brush_rounded,
//     Icons.spa_outlined,
//   ];
//
//   Future<void> pickImg() async {
//     final List<XFile> images = await picker.pickMultiImage(
//       // imageQuality: 100,
//       maxHeight: 500,
//       // maxWidth: 500,
//     );
//     if (images != null) {
//       setState(() {
//         //이미지 추가
//         ReturnList.addAll(images.map((e) => File(e.path)));
//         //전체공개 일부 공개 이것도 넣는거임.
//         ImageOpenList.addAll(List.generate(images.length, (index) => true));
//         // Get.find<AppController>().image_edited = RxBool(true); //이미지리스트 변경했으니 나중에 저장 누르면 이미지 업로드도 진행함.
//       });
//       if (ReturnList.length > 9) {
//         Get.snackbar("!", "사진은 최대 9개까지만 설정 가능합니다. 그 이상 선택하신 것은 나오지 않습니다.");
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //빌드시 마다 새로고침 해야해서 넣은거임.
//     return_list = ReturnList;
//     //이 위젯은 0.0.8 이후로 업데이트 하지마 버그생김. 이 버전으로 그대로 써 심플한거라 그냥 써도 됨.
//     return DraggableGridViewBuilder(
//         dragFeedback: (mylist, index) {
//           return SizedBox(height: 100, width: 100, child: mylist[index].child);
//         },
//         dragPlaceHolder: (list, index) => PlaceHolderWidget(child: Container(color: Colors.transparent)),
//         shrinkWrap: true,
//         isOnlyLongPress: true,
//         physics: NeverScrollableScrollPhysics(),
//         primary: true,
//         dragCompletion: (List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
//           //DraggableGridViewBuilder에서 순서 바꾸면, 그걸 children리스트에 넣은 원래 리스트에는 반영을 안해줘서 이것처럼 임의로 바꿔주는게 필요함.
//           var MovingObject = ReturnList.elementAt(beforeIndex);
//           ReturnList.removeAt(beforeIndex);
//           ReturnList.insert(afterIndex, MovingObject);
//           // Get.find<AppController>().image_edited = RxBool(true); //이미지리스트 변경했으니 나중에 저장 누르면 이미지 업로드도 진행함.
//           var PrevOpen = ImageOpenList.elementAt(beforeIndex);
//           ImageOpenList.removeAt(beforeIndex);
//           ImageOpenList.insert(afterIndex, PrevOpen);
//           //밑에 이게 꼭 있어야함... 순서 바꾸고 다시 리빌드를 해야 나열이 다시 잘 되면서 순서 바꾸면 리빌드를 꼭 해줘야함..
//           // 삭제하는데 쓰는 x 표시가 작동 잘 됨.
//           setState(() {});
//         },
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//         ),
//         children: List.generate(9, (index) {
//           try {
//             return DraggableGridItem(
//                 isDraggable: true,
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     fit: StackFit.passthrough,
//                     children: [
//                       //네트워크에서 받아온 이미지면,네트워크로 이미지화 하고, 파일에서 방금 올린거면,
//                       GestureDetector(
//                         onTap: () {
//                           ImageOpenList[index] = flip_Open(ImageOpenList[index]);
//                           setState(() {});
//                         },
//                         child: ReturnList[index].runtimeType == String
//                             ? CachedNetworkImage(
//                                 imageUrl: ReturnList[index],
//                                 placeholder: (context, url) =>
//                                     // CircularProgressIndicator(color: Colors.black,),
//                                     Container(
//                                   width: 150,
//                                   height: 150,
//                                 ),
//                                 errorWidget: (context, url, error) => Icon(Icons.error),
//                                 fit: BoxFit.cover,
//                                 height: 300,
//                                 width: 300,
//                               )
//                             : Image.file(
//                                 ReturnList[index],
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               ImageOpenList[index] = flip_Open(ImageOpenList[index]);
//                               setState(() {});
//                             },
//                             child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: ImageOpenList[index]
//                                     ? Container(
//                                         decoration: BoxDecoration(
//                                             color: Color.fromRGBO(29, 155, 240, 1),
//                                             borderRadius: BorderRadiusDirectional.all(Radius.circular(15))),
//                                         child: Padding(
//                                           padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
//                                           child: Text(
//                                             "전체공개",
//                                             style: TextStyle(
//                                                 color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
//                                           ),
//                                         ))
//                                     : Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadiusDirectional.all(Radius.circular(15))),
//                                         child: Padding(
//                                           padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
//                                           child: Text(
//                                             "선택공개",
//                                             style: TextStyle(
//                                                 color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w700),
//                                           ),
//                                         ))),
//                           ),
//                           GestureDetector(
//                             onTap: () => setState(() {
//                               //삭제 했을 때
//                               ImageOpenList.removeAt(index);
//
//                               ImageNetworkpnghrefMatch.removeWhere((key, value) => value == ReturnList[index]);
//                               ReturnList.removeAt(index);
//                             }),
//
//                             child: Icon(Icons.close_rounded, size: 20, color: Colors.white),
//                             // Image.asset(
//                             //   "assets/cross.png",
//                             //   width: 30,
//                             //   height: 30,
//                             //   color: Colors.white,
//                             // ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ));
//           } catch (e) {
//             return DraggableGridItem(
//                 child: GestureDetector(
//                     onTap: pickImg,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(244, 246, 248, 1),
//                             borderRadius: BorderRadius.all(Radius.circular(5)),
//                           ),
//                           // border: Border.all(width: 2, color: Colors.grey)),
//                           //border: Border(bottom: BorderSide(width: 2,color: Colors.grey),right: BorderSide(width: 2,color: Colors.grey) )
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(IconList[index], size: 20, color: Colors.grey.shade300),
//                               Icon(Icons.add, size: 20, color: Colors.black),
//                               // SizedBox(width: 15,),
//                             ],
//                           )),
//                     )),
//                 isDraggable: false);
//           }
//         }));
//   }
// }
