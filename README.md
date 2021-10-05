# flutter_draggable_gridview


<a href="https://pub.dev/packages/image_cropping"><img src="https://img.shields.io/pub/v/image_cropping.svg?label=image_cropping" alt="image_cropping version"></a>
<a href="https://github.com/Mindinventory/image_cropping"><img src="https://img.shields.io/github/stars/Mindinventory/image_cropping?style=social" alt="MIT License"></a>
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

This plugin supports cropping and rotating images for multiplatform. It Allow inclusion of background, Rotation of image, changing ratio of selection as per  requirements.


### Allow inclusion of background.
![Image Plugin](https://github.com/Mindinventory/image_cropping/blob/master/assets/image_plugin_1.gif)

### Rotation of image.
![Image Plugin](https://github.com/Mindinventory/image_cropping/blob/master/assets/image_plugin_2.gif)

### Change ratio of selection.
![Image Plugin](https://github.com/Mindinventory/image_cropping/blob/master/assets/image_plugin_3.gif)


## Usage

### Example
    ImageCropper.cropImage(
      context,
      imageBytes!,
      () {
        showLoader();
      },
      () {
        hideLoader();
      },
      (data) {
        setState(() {
          imageBytes = data;
        });
      },
      selectedImageRatio: ImageRatio.RATIO_1_1,
      visibleOtherAspectRatios: true,
      squareBorderWidth: 2,
      squareCircleColor: Colors.black,
      defaultTextColor: Colors.orange,
      selectedTextColor: Colors.black,
      colorForWhiteSpace: Colors.grey,
    );

### Required parameters

##### BuildContext:
context is use to push new screen for image cropping.

##### _imageBytes:
image bytes is use to draw image in device and if image not fits in device screen then we manage background color(if you have passed colorForWhiteSpace or else White background) in image cropping screen.

##### _onImageStartLoading:
this is a callback. you have to override and show dialog or etc when image cropping is in loading state.

##### _onImageEndLoading:
this is a callback. you have to override and hide dialog or etc when image cropping is ready to show result in cropping screen.

##### _onImageDoneListener:
this is a callback. you have to override and you will get Uint8List as result.

## Optional parameters

##### ImageRatio:
this property contains ImageRatio value. You can set the initialized a  spect ratio when starting the cropper by passing a value of ImageRatio. default value is `ImageRatio.FREE`

##### visibleOtherAspectRatios:
this property contains boolean value. If this properties is true then it shows all other aspect ratios in cropping screen. default value is `true`.

##### squareBorderWidth:
this property contains double value. You can change square border width by passing this value.

##### squareCircleColor:
this property contains Color value. You can change square circle color by passing this value.

#####  defaultTextColor:
this property contains Color value. By passing this property you can set aspect ratios color which are unselected.

##### selectedTextColor:
this property contains Color value. By passing this property you can set aspect ratios color which is selected.

##### colorForWhiteSpace:
this property contains Color value. By passing this property you can set background color, if screen contains blank space.


## Note:
The result returns in Uint8List. so it can be lost later, you are responsible for storing it somewhere permanent (if needed).

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
Flutter Draggable GridView is [MIT-licensed](https://github.com/Mindinventory/image_cropping/blob/master/LICENSE "MIT-licensed").

# Let us know!
We’d be really happy if you send us links to your projects where you use our component. Just send an email to sales@mindinventory.com And do let us know if you have any questions or suggestion regarding our work.
