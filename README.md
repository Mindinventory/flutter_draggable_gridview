# flutter_draggable_gridview

<a href="https://pub.dev/packages/image_cropping">
<img src="https://img.shields.io/pub/v/flutter_draggable_gridview?label=flutter_draggable_gridview" alt="flutter_draggable_gridview version">
</a>
<a href="https://github.com/Mindinventory/flutter_draggable_gridview/stargazers">
<img src="https://img.shields.io/github/stars/Mindinventory/flutter_draggable_gridview?style=social" alt="flutter_draggable_gridview Git Stars">
</a>
<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-android-blue">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Linux-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Mac-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-web-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Windows-blue">
</a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>

This package supports drag & drop widgets inside the GridView.builder for multiplatform. It provides all the properties which are available in Gridview.builder and easy to implement with the few lines of code.


### Draggable GridView.
![Draggable GridView](https://github.com/Mindinventory/flutter_draggable_gridview/blob/main/assets/draggable_gridview.gif)


## Usage

### Example
    DraggableGridViewBuilder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3),
        ),
        listOfWidgets: listOfWidgets,
        dragCompletion: this,
        dragFeedback: this,
        dragPlaceHolder: this,
        isOnlyLongPress: false,
      );

### Required parameters

##### gridDelegate:
A delegate that controls the layout of the children within the GridView.

##### listOfWidgets:
This property contains list of widgets and it is use to show the widget inside the GridView.builder to provide the drag & drop functionality.

##### dragCompletion:
This property contains DragCompletion implementation. You have to override and store updated list (if needed).


### Optional parameters

##### isOnlyLongPress:
This property contains ```bool``` value. If this property is ```false``` then it works with simple press draggable or else it works with long press. default value is 'true'. 

##### dragFeedback:
This property contains DragFeedback implementation. If this property overrides then you have to return a Widget and we will use this widget in feedback. Learn more about feedback from [Draggable](https://api.flutter.dev/flutter/widgets/Draggable-class.html#:~:text=Draggable%20class%20Null%20safety,user's%20finger%20across%20the%20screen) class. 

##### dragPlaceHolder:
This property contains DragPlaceHolder implementation. If this property overrides then you have to return a PlaceHolderWidget and we will use this widget in place holder. 

##### dragChildWhenDragging:
This property contains DragChildWhenDragging implementation. If this property overrides then you have to return a Widget and we will display this widget instead of child when drags are under way. Learn more about childWhenDragging from [Draggable](https://api.flutter.dev/flutter/widgets/Draggable-class.html#:~:text=Draggable%20class%20Null%20safety,user's%20finger%20across%20the%20screen) class.


### Last But Not Least :heart_eyes: 
#### You can use all the ```GridView.builder``` properties with ```DraggableGridViewBuilder``` class.


## Note:
The result returns in List. so it can be lost later, you are responsible for storing it somewhere permanent (if needed).

## Guideline for contributors
Contribution towards our repository is always welcome, we request contributors to create a pull request to the develop branch only.

## Guideline to report an issue/feature request
It would be great for us if the reporter can share the below things to understand the root cause of the issue.
- Library version
- Code snippet
- Logs if applicable
- Device specification like (Manufacturer, OS version, etc)
- Screenshot/video with steps to reproduce the issue

# LICENSE!
Flutter Draggable GridView is [MIT-licensed](https://github.com/Mindinventory/flutter_draggable_gridview/blob/main/LICENSE "MIT-licensed").

# Let us know!
We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com And do let us know if you have any questions or suggestion regarding our work.
