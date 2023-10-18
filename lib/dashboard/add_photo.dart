import 'dart:developer';
import 'dart:io';

import 'package:bike_services_vendor/utils/app_style.dart';
import 'package:bike_services_vendor/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_services.dart';
class AddPhotos extends StatefulWidget {
  const AddPhotos({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {

  bool value = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  XFile? frontImageFile;
  XFile? backImageFile;
  XFile? leftImageFile;
  XFile? rightImageFile;

  bool allImagesSelected() {
    return frontImageFile != null &&
        backImageFile != null &&
        leftImageFile != null &&
        rightImageFile != null;
  }

  /// for Select Image
  Future<XFile?> selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    return pickedFile;
  }
  final ApiServices _apiService = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:  GestureDetector(
          onTap: () {
            if (allImagesSelected()) {
              _apiService.addImage(
                frontImageFile!.path,
                backImageFile!.path,
                rightImageFile!.path,
                leftImageFile!.path,
                widget.orderId,
              ).then((value) {
                log("Image1111111111$value");
                Fluttertoast.showToast(msg: "Image Upload Successful");
                Navigator.pop(context,"Uploaded");
              });
            } else {
              Fluttertoast.showToast(msg: "Please select all images.");
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Center(child: Text('Submit',style: TextStyle(fontSize: 16,color:Colors.white))),
          ),
        ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textBlack),
        title: const Text("Service",style: h1Style,),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    selectImage(ImageSource.camera).then((value) {
                      frontImageFile = value;
                      setState(() {});
                    });
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      height: 30,
                      width: 90,
                      child: const Center(child: Text('Front Photo',style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectImage(ImageSource.camera).then((value) {
                      backImageFile = value;
                      setState(() {});
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      height: 30,
                      width: 90,
                      child: const Center(child: Text('Back Photo',style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                frontImageFile?.path != null
                    ? Container(
                  height: 100,
                  width:100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(File(frontImageFile!.path)))),
                )
                    : const SizedBox(),

                backImageFile?.path != null
                    ? Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(File(backImageFile!.path)))),
                )
                    : const SizedBox(),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    selectImage(ImageSource.camera).then((value) {
                      leftImageFile = value;
                      setState(() {});
                    });
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent,
                      ),
                      height: 30,
                      width: 90,
                      child: const Center(child: Text('Left Photo',style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectImage(ImageSource.camera).then((value) {
                      rightImageFile = value;
                      setState(() {});
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      height: 30,
                      width: 90,
                      child: const Center(child: Text('Right Photo',style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                leftImageFile?.path != null
                    ? Container(
                  height: 100,
                  width:100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(File(leftImageFile!.path)))),
                )
                    : const SizedBox(),

                rightImageFile?.path != null
                    ? Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(File(rightImageFile!.path)))),
                )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      )
    );
  }
}
