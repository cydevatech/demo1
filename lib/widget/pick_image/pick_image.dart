import 'package:demo1/widget/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// DEMO
// CustomImagePicker customImagePicker = CustomImagePicker();
//  String? image = '';
//  File? imageFile;
// Future<void> takeImage() async {
//     customImagePicker.openImagePicker(
//       context,
//       'Chọn ảnh minh họa',
//       (ImagePickerResult? result) async {
//         if (result != null) {
//           String? imagePath = result.imagePath;
//           // image = result.imagePath.toString();
//           // if (imagePath != null) {
//           //   imageFile = File(imagePath);
//           //   // Giảm chất lượng ảnh
//           //   File? compressedImage = await reduceImageQuality(
//           //       imageFile!, 90); // Thay đổi giá trị quality theo nhu cầu

//           //   setState(() {
//           //     image = imagePath;
//           //     imageFile = compressedImage; // Sử dụng tệp ảnh đã giảm chất lượng
//           //   });

//           //   print('Đường dẫn hình ảnh: $image');
//           //   print('Đối tượng File ảnh: ${imageFile}');
//           // }
//         } else {
//           print('Cancelled');
//         }
//       },
//     );
//   }
class ImagePickerResult {
  final String? imagePath;

  ImagePickerResult({this.imagePath});
}

class CustomImagePicker {
  Future<ImagePickerResult?> pickImage(
      ImageSource imageSource, BuildContext context) async {
    final picker = ImagePicker();
    Navigator.pop(context);
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return ImagePickerResult(imagePath: null);
    } else {
      return ImagePickerResult(imagePath: pickedFile.path);
    }
  }

  openImagePicker(
    BuildContext _context,
    String text,
    Function(ImagePickerResult?) callback,
  ) async {
    final picker = ImagePicker();
    showModalBottomSheet<ImagePickerResult?>(
      context: _context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 260,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.camera),
                      title: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.camera);

                        callback.call(ImagePickerResult(
                          imagePath: pickedFile?.path,
                        ));
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Color(0xffe5e5e5),
                    ),
                    ListTile(
                      leading: Icon(Icons.picture_in_picture),
                      title: Text(
                        'Thư viện',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        callback.call(ImagePickerResult(
                          imagePath: pickedFile?.path,
                        ));
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: ButtonPrimary(
                        onPress: () {
                          Navigator.pop(context);
                        },
                        disabled: false,
                        text: 'Hủy',
                        colorText: Colors.white,
                        textSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
